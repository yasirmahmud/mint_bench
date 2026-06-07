`define XPR_LEN 32
`define CSR_ADDR_WIDTH 12
`define CSR_CMD_WIDTH 3
`define PRV_WIDTH 2
`define ECODE_WIDTH 4
`define HTIF_PCR_WIDTH 32
`define CSR_COUNTER_WIDTH 64

// CSR commands used in this module's 'cmd' input
`define CSR_WRITE 3'b001 // Implied by default case (CSR_RW)
`define CSR_SET   3'b010 // Corresponds to CSR_RS
`define CSR_CLEAR 3'b011 // Corresponds to CSR_RC

// Exception codes (RISC-V standard or common values)
`define ICODE_TIMER                 4'd7  // Machine timer interrupt
`define ECODE_INST_ADDR_MISALIGNED  4'd0  // Instruction address misaligned

// Privilege levels (RISC-V standard)
`define PRV_U 2'b00 // User mode
`define PRV_M 2'b11 // Machine mode

// Standard RISC-V CSR Addresses
`define CSR_ADDR_MSTATUS    12'h300
`define CSR_ADDR_MTVEC      12'h305
`define CSR_ADDR_MTDELEG    12'h302
`define CSR_ADDR_MIE        12'h304
`define CSR_ADDR_MTIMECMP   12'h321
`define CSR_ADDR_MTIME      12'h721 // Machine Time (read-only in M-mode)
`define CSR_ADDR_MTIMEH     12'h722 // Machine Time High (read-only in M-mode)
`define CSR_ADDR_MSCRATCH   12'h340
`define CSR_ADDR_MEPC       12'h341
`define CSR_ADDR_MCAUSE     12'h342
`define CSR_ADDR_MBADADDR   12'h343
`define CSR_ADDR_MIP        12'h344

// Read-only counter/timer CSRs (accessible from any privilege level)
`define CSR_ADDR_CYCLE      12'hC00
`define CSR_ADDR_TIME       12'hC01
`define CSR_ADDR_INSTRET    12'hC02
`define CSR_ADDR_CYCLEH     12'hC80
`define CSR_ADDR_TIMEH      12'hC81
`define CSR_ADDR_INSTRETH   12'hC82

// Writable counter/timer CSRs (machine-mode only)
`define CSR_ADDR_CYCLEW     12'hB00
`define CSR_ADDR_TIMEW      12'hB01
`define CSR_ADDR_INSTRETW   12'hB02
`define CSR_ADDR_CYCLEHW    12'hB80
`define CSR_ADDR_TIMEHW     12'hB81
`define CSR_ADDR_INSTRETHW  12'hB82

// Machine Information Registers (read-only)
`define CSR_ADDR_MCPUID     12'hF00
`define CSR_ADDR_MIMPID     12'hF01
`define CSR_ADDR_MHARTID    12'hF14

// Non-standard Host Interface (HTIF) CSRs
`define CSR_ADDR_TO_HOST    12'h500
`define CSR_ADDR_FROM_HOST  12'h501

module vscale_csr_file(
                       input                        clk,
                       input                        reset,
                       input [`CSR_ADDR_WIDTH-1:0]  addr,
                       input [`CSR_CMD_WIDTH-1:0]   cmd,
                       input [`XPR_LEN-1:0]         wdata,
                       output wire [`PRV_WIDTH-1:0] prv,
                       output                       illegal_access,
                       output reg [`XPR_LEN-1:0]    rdata,
                       input                        retire,
                       input                        exception,
                       input [`ECODE_WIDTH-1:0]     exception_code,
                       input                        eret,
                       input [`XPR_LEN-1:0]         exception_load_addr,
                       input [`XPR_LEN-1:0]         exception_PC,
                       output [`XPR_LEN-1:0]        handler_PC,
                       output [`XPR_LEN-1:0]        epc,
                       input                        htif_reset,
                       input                        htif_pcr_req_valid,
                       output                       htif_pcr_req_ready,
                       input                        htif_pcr_req_rw,
                       input [`CSR_ADDR_WIDTH-1:0]  htif_pcr_req_addr,
                       input [`HTIF_PCR_WIDTH-1:0]  htif_pcr_req_data,
                       output                       htif_pcr_resp_valid,
                       input                        htif_pcr_resp_ready,
                       output [`HTIF_PCR_WIDTH-1:0] htif_pcr_resp_data
                       );

   localparam HTIF_STATE_IDLE = 0;
   localparam HTIF_STATE_WAIT = 1;

   reg [`HTIF_PCR_WIDTH-1:0]                        htif_rdata;
   reg [`HTIF_PCR_WIDTH-1:0]                        htif_resp_data;
   reg                                              htif_state;
   reg                                              htif_fire;
   reg                                              next_htif_state;

   reg [`CSR_COUNTER_WIDTH-1:0]                     cycle_full;
   reg [`CSR_COUNTER_WIDTH-1:0]                     time_full;
   reg [`CSR_COUNTER_WIDTH-1:0]                     instret_full;
   reg [5:0]                                        priv_stack;
   reg [`XPR_LEN-1:0]                               mtvec;
   reg                                              mtie;
   reg                                              msie;
   reg                                              mtip;
   reg                                              msip;
   reg [`XPR_LEN-1:0]                               mtimecmp;
   reg [`CSR_COUNTER_WIDTH-1:0]                     mtime_full;
   reg [`XPR_LEN-1:0]                               mscratch;
   reg [`XPR_LEN-1:0]                               mepc;
   reg [`ECODE_WIDTH-1:0]                           mecode;
   reg                                              mint;
   reg [`XPR_LEN-1:0]                               mbadaddr;

   wire                                             ie;

   wire [`XPR_LEN-1:0]                              mcpuid;
   wire [`XPR_LEN-1:0]                              mimpid;
   wire [`XPR_LEN-1:0]                              mhartid;
   wire [`XPR_LEN-1:0]                              mstatus;
   wire [`XPR_LEN-1:0]                              mtdeleg;
   wire [`XPR_LEN-1:0]                              mie;
   wire [`XPR_LEN-1:0]                              mip;
   wire [`XPR_LEN-1:0]                              mcause;

   reg [`XPR_LEN-1:0]                               to_host;
   reg [`XPR_LEN-1:0]                               from_host;

   wire                                             mtimer_expired;

   wire                                             host_wen;
   wire                                             system_en;
   wire                                             system_wen;
   wire                                             wen_internal;
   wire                                             illegal_region;
   reg                                              defined;
   reg [`XPR_LEN-1:0]                               wdata_internal;
   wire                                             uinterrupt;
   wire                                             minterrupt;
   reg                                              interrupt_taken;
   reg [`ECODE_WIDTH-1:0]                           interrupt_code;

   wire                                             code_imem;


   wire [`XPR_LEN-1:0]                              padded_prv = prv;
   assign handler_PC = mtvec + (padded_prv << 5);

   assign prv = priv_stack[2:1];
   assign ie = priv_stack[0];

   assign host_wen = (htif_state == HTIF_STATE_IDLE) && htif_pcr_req_valid && htif_pcr_req_rw;
   assign system_en = cmd[2];
   assign system_wen = cmd[1] || cmd[0];
   assign wen_internal = host_wen || system_wen;

   assign illegal_region = (system_wen && (addr[11:10] == 2'b11))
     || (system_en && addr[9:8] > prv);

   assign illegal_access = illegal_region || (system_en && !defined);

   always @(*) begin
      wdata_internal = 32'h12345678;
      if (host_wen) begin
         wdata_internal = htif_pcr_req_data;
      end else if (system_wen) begin
         case (cmd)
           `CSR_SET : wdata_internal = rdata | wdata;
           `CSR_CLEAR : wdata_internal = rdata & ~wdata;
           default : wdata_internal = wdata;
         endcase // case (cmd)
      end
   end // always @ begin

   assign uinterrupt = 1'b0;
   assign minterrupt = (mtie && mtimer_expired);

   always @(*) begin
      interrupt_code = `ICODE_TIMER;
      case (prv)
        `PRV_U : interrupt_taken = (ie && uinterrupt) || minterrupt;
        `PRV_M : interrupt_taken = (ie && minterrupt);
        default : interrupt_taken = 1'b1;
      endcase // case (prv)
   end

   always @(posedge clk) begin
      if (htif_reset)
        htif_state <= HTIF_STATE_IDLE;
      else
        htif_state <= next_htif_state;
      if (htif_fire)
        htif_resp_data <= htif_rdata;
   end

   always @(*) begin
      htif_fire = 1'b0;
      next_htif_state = htif_state;
      case (htif_state)
        HTIF_STATE_IDLE : begin
           if (htif_pcr_req_valid) begin
              htif_fire = 1'b1;
              next_htif_state = HTIF_STATE_WAIT;
           end
        end
        HTIF_STATE_WAIT : begin
           if (htif_pcr_resp_ready) begin
              next_htif_state = HTIF_STATE_IDLE;
           end
        end
      endcase // case (htif_state)
   end // always @ begin

   assign htif_pcr_req_ready = (htif_state == HTIF_STATE_IDLE);
   assign htif_pcr_resp_valid = (htif_state == HTIF_STATE_WAIT);
   assign htif_pcr_resp_data = htif_resp_data;

   assign mcpuid = (1 << 20) | (1 << 8); // 'I' and 'U' bits set
   assign mimpid = 32'h8000;
   assign mhartid = 0;

   always @(posedge clk) begin
      if (reset) begin
         priv_stack <= 6'b000110;
      end else if (wen_internal && addr == `CSR_ADDR_MSTATUS) begin
         priv_stack <= wdata_internal[5:0];
      end else if (exception) begin
         // no delegation to U means all exceptions go to M
         priv_stack <= {priv_stack[2:0],2'b11,1'b0};
      end else if (eret) begin
         priv_stack <= {2'b00,1'b1,priv_stack[5:3]};
      end
   end // always @ (posedge clk)

   assign epc = mepc;

   // this implementation has SD, VM, MPRV, XS, and FS set to 0
   assign mstatus = {(`XPR_LEN-6){1'b0}, priv_stack};

   assign mtdeleg = 0;

   assign mtimer_expired = (mtimecmp == mtime_full[0+:`XPR_LEN]);

   always @(posedge clk) begin
      if (reset) begin
         mtip <= 0;
         msip <= 0;
      end else begin
         if (mtimer_expired)
           mtip <= 1;
         if (wen_internal && addr == `CSR_ADDR_MTIMECMP)
           mtip <= 0;
         if (wen_internal && addr == `CSR_ADDR_MIP) begin
            mtip <= wdata_internal[7];
            msip <= wdata_internal[3];
         end
      end // else: !if(reset)
   end // always @ (posedge clk)
   assign mip = {mtip,3'b0,msip,3'b0};


   always @(posedge clk) begin
      if (reset) begin
         mtie <= 0;
         msie <= 0;
      end else if (wen_internal && addr == `CSR_ADDR_MIE) begin
         mtie <= wdata_internal[7];
         msie <= wdata_internal[3];
      end
   end // always @ (posedge clk)
   assign mie = {mtie,3'b0,msie,3'b0};

   always @(posedge clk) begin
      if (exception || interrupt_taken)
        mepc <= exception_PC & {{(`XPR_LEN-2){1'b1}},2'b0};
      if (wen_internal && addr == `CSR_ADDR_MEPC)
        mepc <= wdata_internal & {{(`XPR_LEN-2){1'b1}},2'b0};
   end

   always @(posedge clk) begin
      if (reset) begin
         mecode <= 0;
         mint <= 0;
      end else if (wen_internal && addr == `CSR_ADDR_MCAUSE) begin
         mecode <= wdata_internal[`ECODE_WIDTH-1:0]; // Ensure correct slicing for mecode
         mint <= wdata_internal[`XPR_LEN-1]; // Mint is highest bit
      end else begin
         if (interrupt_taken) begin
            mecode <= interrupt_code;
            mint <= 1'b1;
         end else if (exception) begin
            mecode <= exception_code;
            mint <= 1'b0;
         end
      end // else: !if(reset)
   end // always @ (posedge clk)
   assign mcause = {mint,{{(`XPR_LEN-1)-`ECODE_WIDTH}{1'b0}},mecode};

   // Original: assign code_imem = (exception_code == `ECODE_INST_ADDR_MISALIGNED) || (exception_code == `ECODE_INST_ADDR_MISALIGNED);
   // Fix: The expression (A || A) is functionally equivalent to A. Removing the redundant part.
   assign code_imem = (exception_code == `ECODE_INST_ADDR_MISALIGNED);

   always @(posedge clk) begin
      if (exception)
        mbadaddr <= (code_imem) ? exception_PC : exception_load_addr;
      if (wen_internal && addr == `CSR_ADDR_MBADADDR)
        mbadaddr <= wdata_internal;
   end

   always @(*) begin
      case (htif_pcr_req_addr)
        `CSR_ADDR_TO_HOST : htif_rdata = to_host;
        `CSR_ADDR_FROM_HOST : htif_rdata = from_host;
        default : htif_rdata = 0;
      endcase // case (htif_pcr_req_addr)
   end // always @ begin

   always @(*) begin
      case (addr)
        `CSR_ADDR_CYCLE     : begin rdata = cycle_full[0+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_TIME      : begin rdata = time_full[0+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_INSTRET   : begin rdata = instret_full[0+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_CYCLEH    : begin rdata = cycle_full[`XPR_LEN+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_TIMEH     : begin rdata = time_full[`XPR_LEN+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_INSTRETH  : begin rdata = instret_full[`XPR_LEN+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_MCPUID    : begin rdata = mcpuid; defined = 1'b1; end
        `CSR_ADDR_MIMPID    : begin rdata = mimpid; defined = 1'b1; end
        `CSR_ADDR_MHARTID   : begin rdata = mhartid; defined = 1'b1; end
        `CSR_ADDR_MSTATUS   : begin rdata = mstatus; defined = 1'b1; end
        `CSR_ADDR_MTVEC     : begin rdata = mtvec; defined = 1'b1; end
        `CSR_ADDR_MTDELEG   : begin rdata = mtdeleg; defined = 1'b1; end
        `CSR_ADDR_MIE       : begin rdata = mie; defined = 1'b1; end
        `CSR_ADDR_MTIMECMP  : begin rdata = mtimecmp; defined = 1'b1; end
        `CSR_ADDR_MTIME     : begin rdata = mtime_full[0+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_MTIMEH    : begin rdata = mtime_full[`XPR_LEN+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_MSCRATCH  : begin rdata = mscratch; defined = 1'b1; end
        `CSR_ADDR_MEPC      : begin rdata = mepc; defined = 1'b1; end
        `CSR_ADDR_MCAUSE    : begin rdata = mcause; defined = 1'b1; end
        `CSR_ADDR_MBADADDR  : begin rdata = mbadaddr; defined = 1'b1; end
        `CSR_ADDR_MIP       : begin rdata = mip; defined = 1'b1; end
        `CSR_ADDR_CYCLEW    : begin rdata = cycle_full[0+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_TIMEW     : begin rdata = time_full[0+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_INSTRETW  : begin rdata = instret_full[0+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_CYCLEHW   : begin rdata = cycle_full[`XPR_LEN+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_TIMEHW    : begin rdata = time_full[`XPR_LEN+:`XPR_LEN]; defined = 1'b1; end
        `CSR_ADDR_INSTRETHW : begin rdata = instret_full[`XPR_LEN+:`XPR_LEN]; defined = 1'b1; end
        // non-standard
        `CSR_ADDR_TO_HOST : begin rdata = to_host; defined = 1'b1; end
        `CSR_ADDR_FROM_HOST : begin rdata = from_host; defined = 1'b1; end
        default : begin rdata = 0; defined = 1'b0; end
      endcase // case (addr)
   end // always @ (*)


   always @(posedge clk) begin
      if (reset) begin
         cycle_full <= 0;
         time_full <= 0;
         instret_full <= 0;
         mtime_full <= 0;
         to_host <= 0;
         from_host <= 0;
         mtvec <= 'h100;
      end else begin
         cycle_full <= cycle_full + 1;
         time_full <= time_full + 1;
         if (retire)
           instret_full <= instret_full + 1;
         mtime_full <= mtime_full + 1;
         if (wen_internal) begin
            case (addr)
              `CSR_ADDR_CYCLE     : cycle_full[0+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_TIME      : time_full[0+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_INSTRET   : instret_full[0+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_CYCLEH    : cycle_full[`XPR_LEN+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_TIMEH     : time_full[`XPR_LEN+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_INSTRETH  : instret_full[`XPR_LEN+:`XPR_LEN] <= wdata_internal;
              // mcpuid is read-only
              // mimpid is read-only
              // mhartid is read-only
              // mstatus handled separately
              `CSR_ADDR_MTVEC     : mtvec <= wdata_internal & {{(`XPR_LEN-2){1'b1}},2'b0};
              // mtdeleg constant
              // mie handled separately
              `CSR_ADDR_MTIMECMP  : mtimecmp <= wdata_internal;
              `CSR_ADDR_MTIME     : mtime_full[0+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_MTIMEH    : mtime_full[`XPR_LEN+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_MSCRATCH  : mscratch <= wdata_internal;
              // mepc handled separately
              // mcause handled separately
              // mbadaddr handled separately
              // mip handled separately
              `CSR_ADDR_CYCLEW    : cycle_full[0+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_TIMEW     : time_full[0+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_INSTRETW  : instret_full[0+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_CYCLEHW   : cycle_full[`XPR_LEN+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_TIMEHW    : time_full[`XPR_LEN+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_INSTRETHW : instret_full[`XPR_LEN+:`XPR_LEN] <= wdata_internal;
              `CSR_ADDR_TO_HOST   : to_host <= wdata_internal;
              `CSR_ADDR_FROM_HOST : from_host <= wdata_internal;
              default : ;
            endcase // case (addr)
         end // if (wen_internal)
         if (htif_fire && htif_pcr_req_addr == `CSR_ADDR_TO_HOST && !system_wen) begin
            to_host <= 0;
         end
      end // else: !if(reset)
   end // always @ (posedge clk)



endmodule
