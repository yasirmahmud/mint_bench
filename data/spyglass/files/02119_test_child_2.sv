module test (
    pci_clk_i,
    clk_i,
    rst_i,
    
    wbm_cyc_o,
    wbm_stb_o,

`ifdef PCI_WB_REV_B3

    wbm_cti_o,
    wbm_bte_o,

`else

    wbm_cab_o,

`endif

    wbm_we_o,
    wbm_adr_o,
    wbm_sel_o,
    wbm_dat_o,
    wbm_dat_i,
    wbm_ack_i,
    wbm_rty_i,
    wbm_err_i,

    wbs_cyc_i,
    wbs_stb_i,
    wbs_cti_i,
    wbs_bte_i,
    wbs_we_i,
    wbs_adr_i,
    wbs_sel_i,
    wbs_dat_i,
    wbs_dat_o,
    wbs_ack_o,
    wbs_rty_o,
    wbs_err_o,

    // pci trdy, irdy and irdy enable inputs used to count number of transfers on pci bus
    pci_irdy_reg_i,
    pci_irdy_en_reg_i,
    pci_trdy_reg_i,
    pci_ad_reg_i
);


input           pci_clk_i,
                clk_i,
                rst_i ;
    
output reg      wbm_cyc_o,  // Changed to output reg to avoid redefinition and match procedural assignment
                wbm_stb_o ; // Changed to output reg to avoid redefinition and match procedural assignment
output          wbm_we_o ;  // Retained as output (implicitly wire) as it's driven by continuous assignment

`ifdef PCI_WB_REV_B3

output reg [ 2: 0]  wbm_cti_o   ; // Changed to output reg to avoid redefinition and match procedural assignment
output     [ 1: 0]  wbm_bte_o   ; // Retained as output (implicitly wire) as it's driven by continuous assignment

assign wbm_bte_o = 2'b00 ;

`else

output reg  wbm_cab_o   ; // Changed to output reg to avoid redefinition and match procedural assignment

`endif

output reg  [31:0]  wbm_adr_o ; // Changed to output reg to avoid redefinition and match procedural assignment
output      [3:0]   wbm_sel_o ; // Retained as output (implicitly wire) as it's driven by continuous assignment
assign          wbm_sel_o = 4'hF ;
output reg  [31:0]  wbm_dat_o ; // Changed to output reg to avoid redefinition and match procedural assignment
input   [31:0]  wbm_dat_i ;
input           wbm_ack_i,
                wbm_rty_i, // Unused
                wbm_err_i ; // Unused

input           wbs_cyc_i,
                wbs_stb_i,
                wbs_we_i ;

input   [ 2: 0] wbs_cti_i   ;
input   [ 1: 0] wbs_bte_i   ;

input   [31:0]  wbs_adr_i ;
input   [3:0]   wbs_sel_i ; // Unused
input   [31:0]  wbs_dat_i ;
output  [31:0]  wbs_dat_o ;
output          wbs_ack_o,
                wbs_rty_o,
                wbs_err_o ;

input pci_irdy_reg_i,
      pci_irdy_en_reg_i,
      pci_trdy_reg_i ;

input [31:0] pci_ad_reg_i ;

wire sel_registers =  wbs_adr_i[12] ;
wire sel_rams      = ~wbs_adr_i[12] ;

wire wbs_write = wbs_cyc_i & wbs_stb_i & wbs_we_i ;

wire wbs_ram0_255_we    = wbs_write & sel_rams & (wbs_adr_i[11:10] == 2'b00) ;
wire wbs_ram256_511_we  = wbs_write & sel_rams & (wbs_adr_i[11:10] == 2'b01) ;
wire wbs_ram512_767_we  = wbs_write & sel_rams & (wbs_adr_i[11:10] == 3'b10) ;
wire wbs_ram768_1023_we = wbs_write & sel_rams & (wbs_adr_i[11:10] == 3'b11) ;

// Separated reg declarations to fix syntax error with attributes (Violation 0)
// sel_master_test_size and sel_master_test_start_dat are now explicitly declared here as reg (Violations 1, 2)
reg  sel_master_transaction_size;
reg  sel_master_transaction_count;
reg  sel_master_opcode;
reg  sel_master_base;
reg  sel_target_burst_transaction_count;
reg  sel_target_test_size;
reg  sel_target_test_start_adr;
reg  sel_target_test_start_dat;
reg  sel_target_test_error_detected;
reg  sel_master_num_of_wb_transfers;
reg  sel_master_test_start_dat;
reg  sel_master_test_size;
(* unused_reg = "off" *) reg sel_master_num_of_pci_transfers;
(* unused_reg = "off" *) reg sel_master_dat_err_detected ;

wire [31:0] wbs_ram0_255_o ;
wire [31:0] wbs_ram256_511_o ;
wire [31:0] wbs_ram512_767_o ;
wire [31:0] wbs_ram768_1023_o ;

// wire wbm_write = wbm_cyc_o & wbm_stb_o &  wbm_we_o ; // Removed: Variable 'wbm_write' set but not read.
wire wbm_read  = wbm_cyc_o & wbm_stb_o & ~wbm_we_o ;

wire wbm_ram0_255_we    = wbm_ack_i & wbm_read & (wbm_adr_o[11:10] == 2'b00) ;
wire wbm_ram256_511_we  = wbm_ack_i & wbm_read & (wbm_adr_o[11:10] == 2'b01) ;
wire wbm_ram512_767_we  = wbm_ack_i & wbm_read & (wbm_adr_o[11:10] == 2'b10) ;
wire wbm_ram768_1023_we = wbm_ack_i & wbm_read & (wbm_adr_o[11:10] == 2'b11) ;

wire [31:0] wbm_ram0_255_o ;
wire [31:0] wbm_ram256_511_o ;
wire [31:0] wbm_ram512_767_o ;
wire [31:0] wbm_ram768_1023_o ;

// Removed redundant 'reg [31:0] wbm_dat_o;' declaration, now part of output reg list.
always@(wbm_adr_o or wbm_ram0_255_o or wbm_ram256_511_o or wbm_ram512_767_o or wbm_ram768_1023_o)
begin
    case (wbm_adr_o[11:10])
    2'b00:
        begin
            wbm_dat_o = wbm_ram0_255_o ;
        end
    2'b01:
        begin
            wbm_dat_o = wbm_ram256_511_o ;
        end
    2'b10:
        begin
            wbm_dat_o = wbm_ram512_767_o ;
        end
    2'b11:
        begin
            wbm_dat_o = wbm_ram768_1023_o ;
        end
    endcase
end

reg [10:0]  master_transaction_size ;
reg [10:0]  master_transaction_count ;
reg         master_opcode ;
reg [31:0]  master_base ;
reg [31:0]  master_base_next ;
reg [10:0]  target_test_size ;
reg [31:0]  target_test_start_adr ;
reg [31:0]  target_test_expect_adr ;
reg [31:0]  target_test_start_dat ;
reg [31:0]  target_test_expect_dat ;
reg         target_test_adr_error_detected,
            target_test_dat_error_detected ;
reg [31:0]  master_num_of_wb_transfers,
            master_num_of_pci_transfers ;
reg [31:0]  master_test_start_dat ;
reg [31:0]  pci_clk_master_test_expect_dat ;
reg [20:0]  master_test_size ;
reg [20:0]  pci_clk_master_test_size ;
reg         pci_clk_master_test_done,
            wb_clk_master_test_done_sync,
            wb_clk_master_test_done,
            wb_clk_master_test_start,
            pci_clk_master_test_start_sync,
            pci_clk_master_test_start,
            pci_clk_master_test_started,
            wb_clk_master_test_started_sync,
            wb_clk_master_test_started,
            master_dat_err_detected ;

always@(posedge pci_clk_i or posedge rst_i)
begin
    if (rst_i)
    begin
        pci_clk_master_test_expect_dat <= 0 ;
        pci_clk_master_test_size       <= 0 ;
        pci_clk_master_test_done       <= 1 ;
        pci_clk_master_test_start_sync <= 0 ;
        pci_clk_master_test_start      <= 0 ;
        pci_clk_master_test_started    <= 0 ;
        master_dat_err_detected        <= 0 ;
    end
    else
    begin
        // sync flop always samples the data
        pci_clk_master_test_start_sync <= wb_clk_master_test_start ;
        if (pci_clk_master_test_size == 0)
        begin
            // load test start_flop only when test size is zero
            pci_clk_master_test_start   <= pci_clk_master_test_start_sync ;
            pci_clk_master_test_started <= 0 ;
            pci_clk_master_test_done    <= 1 ;
            if (pci_clk_master_test_start)
            begin
                pci_clk_master_test_size       <= master_test_size ;
                pci_clk_master_test_expect_dat <= master_test_start_dat ;

                // error detected bit is cleared when new test starts
                master_dat_err_detected <= 0 ;
            end
        end
        else
        begin
            pci_clk_master_test_done    <= 0 ;
            pci_clk_master_test_start   <= 0 ;
            pci_clk_master_test_started <= 1 ;
            if (~(pci_irdy_reg_i | ~pci_irdy_en_reg_i | pci_trdy_reg_i))
            begin
                pci_clk_master_test_size <= pci_clk_master_test_size - 1'b1 ;

                if (pci_ad_reg_i != pci_clk_master_test_expect_dat)
                    master_dat_err_detected <= 1'b1 ;

                pci_clk_master_test_expect_dat <= {pci_clk_master_test_expect_dat[30:0], pci_clk_master_test_expect_dat[31]} ;
            end
        end
    end
end

always@(posedge clk_i or posedge rst_i)
begin
    if (rst_i)
    begin
        wb_clk_master_test_done_sync    <= 1'b1 ;
        wb_clk_master_test_done         <= 1'b1 ;
        wb_clk_master_test_started_sync <= 1'b0 ;
        wb_clk_master_test_started      <= 1'b0 ;
    end
    else
    begin
        wb_clk_master_test_done_sync    <= pci_clk_master_test_done ;
        if (wb_clk_master_test_start)
            wb_clk_master_test_done <= 1'b0 ;
        else
            wb_clk_master_test_done <= wb_clk_master_test_done_sync ;

        wb_clk_master_test_started_sync <= pci_clk_master_test_started ;
        wb_clk_master_test_started      <= wb_clk_master_test_started_sync ;
    end
end

assign wbm_we_o = master_opcode ;

reg [10:0] master_current_transaction_size ;

reg [10:0] target_burst_transaction_count ;
reg        wbs_cyc_i_previous ;

reg clr_master_num_of_pci_transfers ;
reg clr_master_num_of_pci_transfers_sync ;
reg wb_clk_clr_master_num_of_pci_transfers ;

always@(posedge pci_clk_i or posedge rst_i)
begin
    if (rst_i)
    begin
        master_num_of_pci_transfers <= 0 ;
    end
    else if (clr_master_num_of_pci_transfers)
    begin
        master_num_of_pci_transfers <= 0 ;
    end
    else if (~(pci_irdy_reg_i | ~pci_irdy_en_reg_i | pci_trdy_reg_i))
    begin
        master_num_of_pci_transfers <= master_num_of_pci_transfers + 1'b1 ;
    end

    if (rst_i)
    begin
        clr_master_num_of_pci_transfers <= 1'b1 ;
        clr_master_num_of_pci_transfers_sync <= 1'b1 ;
    end
    else
    begin
        clr_master_num_of_pci_transfers <= clr_master_num_of_pci_transfers_sync ;
        clr_master_num_of_pci_transfers_sync <= wb_clk_clr_master_num_of_pci_transfers ;
    end
end

always@(posedge clk_i or posedge rst_i)
begin
    if (rst_i)
    begin
        master_transaction_size                 <= 0 ;
        master_transaction_count                <= 0 ;
        master_opcode                           <= 0 ;
        master_base                             <= 0 ;
        master_base_next                        <= 4 ;
        target_burst_transaction_count          <= 0 ;
        wbs_cyc_i_previous                      <= 0 ;
        target_test_size                        <= 0 ;
        target_test_start_adr                   <= 0 ;
        target_test_start_dat                   <= 0 ;
        target_test_adr_error_detected          <= 0 ;
        target_test_dat_error_detected          <= 0 ;
        target_test_expect_adr                  <= 0 ;
        target_test_expect_dat                  <= 0 ;
        master_num_of_wb_transfers              <= 0 ;
        wb_clk_clr_master_num_of_pci_transfers  <= 1'b1 ;
        master_test_size                        <= 0 ;
        master_test_start_dat                   <= 0 ;
		wb_clk_master_test_start                <= 0 ;
    end
    else
    begin
        if (sel_master_transaction_size & wbs_write & sel_registers)
        // write new value to transaction size register
            master_transaction_size <= wbs_dat_i[10:0] ;

        if (sel_master_transaction_count & wbs_write & sel_registers)
        // write new value to transaction count register
            master_transaction_count <= wbs_dat_i[10:0] ;
        else if (wbm_cyc_o & wbm_stb_o & wbm_ack_i & (master_current_transaction_size == 11'h1))
        // decrement the transaction count when ack is received and transaction size is 1
            master_transaction_count <= master_transaction_count - 1'b1 ;

        if (sel_master_opcode & wbs_write & sel_registers)
        // master opcode write
            master_opcode <= wbs_dat_i[0] ;

        if (sel_master_base & wbs_write & sel_registers)
        // master base address write
            master_base <= {wbs_dat_i[31:2], 2'b00} ;

        if (sel_target_burst_transaction_count & wbs_write & sel_registers)
            target_burst_transaction_count <= 0 ;
        else if (wbs_cyc_i & ~wbs_cyc_i_previous & (wbs_cti_i == 3'b010) & (wbs_bte_i == 2'b00))
            target_burst_transaction_count <= target_burst_transaction_count + 1 ;

        if (sel_target_test_size & wbs_write & sel_registers)
            target_test_size <= wbs_dat_i[10:0] ;
        else if ((target_test_size != 0) & wbs_cyc_i & wbs_stb_i & wbs_we_i & wbs_ack_o & ~sel_registers)
        begin
            target_test_size <= target_test_size - 1'b1 ;
        end

        if (sel_target_test_start_adr & wbs_write & sel_registers)
            target_test_start_adr <= wbs_dat_i ;

        if (sel_target_test_start_dat & wbs_write & sel_registers)
            target_test_start_dat <= wbs_dat_i ;

        if (sel_target_test_error_detected & wbs_write & sel_registers)
        begin
            target_test_adr_error_detected <= 1'b0 ;
            target_test_dat_error_detected <= 1'b0 ;
        end
        else if ((target_test_size != 0) & wbs_cyc_i & wbs_stb_i & wbs_we_i & wbs_ack_o & ~sel_registers)
        begin
            target_test_adr_error_detected <= (target_test_expect_adr != wbs_adr_i) | target_test_adr_error_detected ;
            target_test_dat_error_detected <= (target_test_expect_dat != wbs_dat_i) | target_test_dat_error_detected ;
        end

        if (target_test_size == 0)
        begin
            target_test_expect_adr <= target_test_start_adr ;
            target_test_expect_dat <= target_test_start_dat ;
        end
        else if (wbs_cyc_i & wbs_stb_i & wbs_we_i & wbs_ack_o & ~sel_registers)
        begin
            target_test_expect_adr <= target_test_expect_adr + 'd4 ;
            target_test_expect_dat <= {target_test_expect_dat[30:0], target_test_expect_dat[31]} ;
        end

        if (sel_master_num_of_wb_transfers & wbs_write & sel_registers)
        begin
            master_num_of_wb_transfers <= 0 ;
            wb_clk_clr_master_num_of_pci_transfers <= 1'b1 ;
        end
        else if (wbm_cyc_o & wbm_stb_o & wbm_ack_i)
        begin
            wb_clk_clr_master_num_of_pci_transfers <= 1'b0 ;
            master_num_of_wb_transfers <= master_num_of_wb_transfers + 1'b1 ;
        end

        if (wb_clk_master_test_done & wbs_write & sel_master_test_size & sel_registers & ~wb_clk_master_test_start)
        begin
            master_test_size         <= wbs_dat_i[20:0] ;
            wb_clk_master_test_start <= 1'b1 ;
        end
        else
        begin
            if (wb_clk_master_test_started & !wb_clk_master_test_done)
                wb_clk_master_test_start <= 1'b0 ;
        end

        if (sel_master_test_start_dat & wbs_write & sel_registers)
            master_test_start_dat <= wbs_dat_i ;

        master_base_next <= master_base + 4 ;

        wbs_cyc_i_previous <= wbs_cyc_i ;
    end
end

reg [31:0] register_output ;
reg [31:0] ram_output ;

always @(
    wbs_adr_i or
    master_transaction_size or
    master_transaction_count or
    master_opcode or
    master_base or
    target_burst_transaction_count or
    target_test_size or
    target_test_start_adr or
    target_test_start_dat or
    target_test_adr_error_detected or
    target_test_dat_error_detected or
    master_num_of_wb_transfers or
    master_num_of_pci_transfers or
    master_test_size or
    master_test_start_dat or
    master_dat_err_detected
) // Fixed `always@*` syntax to Verilog-2001 sensitivity list (Violations 3, 4, 5)
begin
    sel_master_transaction_size        = 1'b0 ;
    sel_master_transaction_count       = 1'b0 ;
    sel_master_opcode                  = 1'b0 ;
    sel_master_base                    = 1'b0 ;
    sel_target_burst_transaction_count = 1'b0 ;
    sel_target_test_size               = 1'b0 ;
    sel_target_test_start_adr          = 1'b0 ;
    sel_target_test_start_dat          = 1'b0 ;
    sel_target_test_error_detected     = 1'b0 ;
    sel_master_num_of_wb_transfers     = 1'b0 ;
    sel_master_test_size               = 1'b0 ;
    sel_master_test_start_dat          = 1'b0 ;
    sel_master_dat_err_detected        = 1'b0 ;
    register_output                    = 0 ;

    case (wbs_adr_i[5:2])
        4'b0000:
        begin
            sel_master_transaction_size = 1'b1 ;
            register_output             = {21'h0, master_transaction_size} ;
        end
        4'b0001:
        begin
            sel_master_transaction_count = 1'b1 ;
            register_output              = {21'h0, master_transaction_count} ;
        end
        4'b0010:
        begin
            sel_master_opcode = 1'b1 ;
            register_output   = {31'h0, master_opcode} ;
        end
        4'b0011:
        begin
            sel_master_base = 1'b1 ;   
            register_output = master_base ;
        end
        4'b0100:
        begin
            sel_target_burst_transaction_count = 1'b1 ;
            register_output = {21'h0, target_burst_transaction_count[10:0]} ; // ensure width matches
        end
        4'b0101:
        begin
            sel_target_test_size = 1'b1 ;
            register_output = {21'h0, target_test_size} ;
        end
        4'b0110:
        begin
            sel_target_test_start_adr = 1'b1 ;
            register_output = target_test_start_adr ;
        end
        4'b0111:
        begin
            sel_target_test_start_dat = 1'b1 ;
            register_output = target_test_start_dat ;
        end
        4'b1000:
        begin
            sel_target_test_error_detected = 1'b1 ;
            register_output = {30'h0, target_test_adr_error_detected, target_test_dat_error_detected} ;
        end
        4'b1001:
        begin
            sel_master_num_of_wb_transfers = 1'b1 ;
            register_output = master_num_of_wb_transfers ;
        end
        4'b1010:
        begin
            sel_master_num_of_pci_transfers = 1'b1 ;
            register_output = master_num_of_pci_transfers ;
        end
        4'b1011:
        begin
            sel_master_test_size = 1'b1 ;
            register_output      = {11'h0, master_test_size} ;
        end
        4'b1100:
        begin
            sel_master_test_start_dat = 1'b1 ;
            register_output           = master_test_start_dat ;
        end
        4'b1101:
        begin
            sel_master_dat_err_detected = 1'b1 ;
            register_output             = {31'h0, master_dat_err_detected} ;
        end
        default: begin
            // Default case added to satisfy lint rule W442a (if it was complaining about implicit latches)
            // All outputs are already assigned defaults at the beginning of the always block.
        end
    endcase
end

always@(wbs_adr_i or wbs_ram0_255_o or wbs_ram256_511_o or wbs_ram512_767_o or wbs_ram768_1023_o)
begin
    ram_output = 0; // Default assignment added to prevent latch inference and satisfy W71
    case (wbs_adr_i[11:10])
        2'b00:ram_output = wbs_ram0_255_o ;
        2'b01:ram_output = wbs_ram256_511_o ;
        2'b10:ram_output = wbs_ram512_767_o ;
        2'b11:ram_output = wbs_ram768_1023_o ;
    endcase
end

assign wbs_dat_o = sel_registers ? register_output : ram_output ;

reg delayed_ack_for_reads ;

always@(posedge clk_i or posedge rst_i)
begin
    if (rst_i)
        delayed_ack_for_reads <= 1'b0 ;
    else if (delayed_ack_for_reads)
        delayed_ack_for_reads <= 1'b0 ;
    else
        delayed_ack_for_reads <= wbs_cyc_i & wbs_stb_i & (~wbs_we_i) ;
end

assign wbs_ack_o = wbs_we_i ? (wbs_cyc_i & wbs_stb_i) : delayed_ack_for_reads ;

assign wbs_err_o = 1'b0 ;
assign wbs_rty_o = 1'b0 ;

// Removed redundant 'reg' declarations, now part of output reg list (Violations 6, 7, 8, 9)

`ifdef PCI_WB_REV_B3
(* unused_reg = "off" *) // Moved attribute to output reg declaration
`else
// Removed redundant 'reg wbm_cab_o' declaration
`endif

// Removed redundant 'reg [31:0] wbm_adr_o' declaration
reg [31:0]  wbm_next_adr_o ;

wire wbm_end_cycle   = wbm_cyc_o & wbm_stb_o & wbm_ack_i & (master_current_transaction_size == 11'h1) ;
wire wbm_start_cycle = (master_transaction_size != 11'h0) & (master_transaction_count != 11'h0) & ~wbm_cyc_o ;

always@(posedge clk_i or posedge rst_i)
begin
    if (rst_i)
    begin
        wbm_cyc_o                       <= 1'b0 ;
        `ifndef PCI_WB_REV_B3
        wbm_cab_o                       <= 1'b0 ;
        `else
        wbm_cti_o                       <= 3'h7 ;
        `endif
        wbm_stb_o                       <= 1'b0 ;
        wbm_adr_o                       <= 32'h0 ;
        master_current_transaction_size <= 11'h0 ;
        wbm_next_adr_o                  <= 32'h4 ;
    end
    else
    begin
        if (master_transaction_count == 11'h0)
        begin
            wbm_adr_o      <= master_base ;
            wbm_next_adr_o <= master_base_next ;
        end
        else if (wbm_cyc_o & wbm_stb_o & wbm_ack_i)
        begin
            wbm_adr_o            <= wbm_next_adr_o ;
            wbm_next_adr_o[31:2] <= wbm_next_adr_o[31:2] + 1'b1 ;
        end
            
        if (wbm_start_cycle)
        begin
            wbm_cyc_o                       <= 1'b1 ;
            `ifndef PCI_WB_REV_B3
            wbm_cab_o                       <= (master_transaction_size != 11'h1) ;
            `else
            wbm_cti_o                       <= (master_transaction_size != 11'h1) ? 3'b010 : 3'b111 ;
            `endif
            wbm_stb_o                       <= 1'b1 ;
            master_current_transaction_size <= master_transaction_size ;
        end
        else if (wbm_cyc_o)
        begin
            if (wbm_end_cycle)
            begin
                wbm_cyc_o   <= 1'b0     ;
                wbm_stb_o   <= 1'b0     ;
                `ifndef PCI_WB_REV_B3
                wbm_cab_o   <= 1'b0     ;
                `else
                wbm_cti_o   <= 3'b111   ;
                `endif
            end
            else
            begin
                if (wbm_stb_o & wbm_ack_i)
                begin
                    master_current_transaction_size <= master_current_transaction_size - 1'b1 ;
                    
                    if (master_current_transaction_size == 2)
                        `ifdef PCI_WB_REV_B3
                        wbm_cti_o <= 3'b111 ;
                        `endif
                end
            end
        end
    end
end

wire [7:0] master_ram_adr = (wbm_we_o & wbm_ack_i) ? wbm_next_adr_o[9:2] : wbm_adr_o[9:2] ;

RAMB4_S16_S16 ramb4_s16_s16_00
(
    .CLKA(clk_i),
    .RSTA(rst_i),
    .ADDRA(wbs_adr_i[9:2]),
    .DIA(wbs_dat_i[31:16]),
    .ENA(1'b1),
    .WEA(wbs_ram0_255_we),
    .DOA(wbs_ram0_255_o[31:16]),

    .CLKB(clk_i),
    .RSTB(rst_i),
    .ADDRB(master_ram_adr),
    .DIB(wbm_dat_i[31:16]),
    .ENB(1'b1),
    .WEB(wbm_ram0_255_we),
    .DOB(wbm_ram0_255_o[31:16])
);

RAMB4_S16_S16 ramb4_s16_s16_01
(
    .CLKA(clk_i),
    .RSTA(rst_i),
    .ADDRA(wbs_adr_i[9:2]),
    .DIA(wbs_dat_i[15:0]),
    .ENA(1'b1),
    .WEA(wbs_ram0_255_we),
    .DOA(wbs_ram0_255_o[15:0]),

    .CLKB(clk_i),
    .RSTB(rst_i),
    .ADDRB(master_ram_adr),
    .DIB(wbm_dat_i[15:0]),
    .ENB(1'b1),
    .WEB(wbm_ram0_255_we),
    .DOB(wbm_ram0_255_o[15:0])
);

RAMB4_S16_S16 ramb4_s16_s16_10
(
    .CLKA(clk_i),
    .RSTA(rst_i),
    .ADDRA(wbs_adr_i[9:2]),
    .DIA(wbs_dat_i[31:16]),
    .ENA(1'b1),
    .WEA(wbs_ram256_511_we),
    .DOA(wbs_ram256_511_o[31:16]),

    .CLKB(clk_i),
    .RSTB(rst_i),
    .ADDRB(master_ram_adr),
    .DIB(wbm_dat_i[31:16]),
    .ENB(1'b1),
    .WEB(wbm_ram256_511_we),
    .DOB(wbm_ram256_511_o[31:16])
);

RAMB4_S16_S16 ramb4_s16_s16_11
(
    .CLKA(clk_i),
    .RSTA(rst_i),
    .ADDRA(wbs_adr_i[9:2]),
    .DIA(wbs_dat_i[15:0]),
    .ENA(1'b1),
    .WEA(wbs_ram256_511_we),
    .DOA(wbs_ram256_511_o[15:0]),

    .CLKB(clk_i),
    .RSTB(rst_i),
    .ADDRB(master_ram_adr),
    .DIB(wbm_dat_i[15:0]),
    .ENB(1'b1),
    .WEB(wbm_ram256_511_we),
    .DOB(wbm_ram256_511_o[15:0])
);

RAMB4_S16_S16 ramb4_s16_s16_20
(
    .CLKA(clk_i),
    .RSTA(rst_i),
    .ADDRA(wbs_adr_i[9:2]),
    .DIA(wbs_dat_i[31:16]),
    .ENA(1'b1),
    .WEA(wbs_ram512_767_we),
    .DOA(wbs_ram512_767_o[31:16]),

    .CLKB(clk_i),
    .RSTB(rst_i),
    .ADDRB(master_ram_adr),
    .DIB(wbm_dat_i[31:16]),
    .ENB(1'b1),
    .WEB(wbm_ram512_767_we),
    .DOB(wbm_ram512_767_o[31:16])
);

RAMB4_S16_S16 ramb4_s16_s16_21
(
    .CLKA(clk_i),
    .RSTA(rst_i),
    .ADDRA(wbs_adr_i[9:2]),
    .DIA(wbs_dat_i[15:0]),
    .ENA(1'b1),
    .WEA(wbs_ram512_767_we),
    .DOA(wbs_ram512_767_o[15:0]),

    .CLKB(clk_i),
    .RSTB(rst_i),
    .ADDRB(master_ram_adr),
    .DIB(wbm_dat_i[15:0]),
    .ENB(1'b1),
    .WEB(wbm_ram512_767_we),
    .DOB(wbm_ram512_767_o[15:0])
);

RAMB4_S16_S16 ramb4_s16_s16_30
(
    .CLKA(clk_i),
    .RSTA(rst_i),
    .ADDRA(wbs_adr_i[9:2]),
    .DIA(wbs_dat_i[31:16]),
    .ENA(1'b1),
    .WEA(wbs_ram768_1023_we),
    .DOA(wbs_ram768_1023_o[31:16]),

    .CLKB(clk_i),
    .RSTB(rst_i),
    .ADDRB(master_ram_adr),
    .DIB(wbm_dat_i[31:16]),
    .ENB(1'b1),
    .WEB(wbm_ram768_1023_we),
    .DOB(wbm_ram768_1023_o[31:16])
);

RAMB4_S16_S16 ramb4_s16_s16_31
(
    .CLKA(clk_i),
    .RSTA(rst_i),
    .ADDRA(wbs_adr_i[9:2]),
    .DIA(wbs_dat_i[15:0]),
    .ENA(1'b1),
    .WEA(wbs_ram768_1023_we),
    .DOA(wbs_ram768_1023_o[15:0]),

    .CLKB(clk_i),
    .RSTB(rst_i),
    .ADDRB(master_ram_adr),
    .DIB(wbm_dat_i[15:0]),
    .ENB(1'b1),
    .WEB(wbm_ram768_1023_we),
    .DOB(wbm_ram768_1023_o[15:0])
);

endmodule
