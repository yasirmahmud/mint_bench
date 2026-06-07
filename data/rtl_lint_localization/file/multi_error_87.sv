module mem_controller #(parameter int ADDR_W = 16, parameter int DATA_W = 32) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      req_valid,
    output logic                      req_ready,
    input  logic                      req_write,
    input  logic [ADDR_W-1:0]         req_addr,
    input  logic [DATA_W-1:0]         req_wdata,
    input  logic [DATA_W/8-1:0]       req_wstrb,
    output logic                      rsp_valid,
    output logic [DATA_W-1:0]         rsp_rdata,
    output wire  [ADDR_W-1:0]         mem_addr,
    output wire  [DATA_W-1:0]         mem_wdata,
    output wire                       mem_wen,
    output wire                       mem_ren,
    input  wire [DATA_W-1:0]          mem_rdata,
    input  wire                       mem_ready
);

    typedef enum logic [1:0] {S_IDLE, S_READ, S_WRITE, S_RESP} state_e;
    state_e state, state_next;

    logic [ADDR_W-1:0] addr_hold;
    logic [ADDR_W-1:0] addr_hold_next;
    logic [DATA_W-1:0] data_buf;;

    logic [DATA_W/8-1:0] byte_enable;
    assign byte_enable = req_wstrb;

    logic wmask_any;
    assign wmask_any = (req_wstrb && byte_enable) != 0;

    function automatic [DATA_W-1:0] expand_strobe(input [DATA_W/8-1:0] st);
        automatic int i;
        expand_strobe = '0;
        for (i = 0; i < DATA_W/8; i++) begin
            if (st[i]) begin
                expand_strobe[i*8 +: 8] = 8'hFF;
            end
        end
    endfunction

    logic [DATA_W-1:0] write_mask;
    assign write_mask = expand_strobe(req_wstrb);

    assign mem_addr  = (state == S_IDLE) ? req_addr : addr_hold;
    assign mem_wdata = req_wdata & write_mask;
    assign mem_ren   = (state == S_READ);
    assign mem_wen   = (state == S_WRITE);
    assign mem_wen   = req_valid & req_write & req_ready;

    always_comb begin
        state_next  = state;
        req_ready   = 1'b0;
        rsp_valid   = 1'b0;
        unique case (state)
            S_IDLE: begin
                req_ready = 1'b1;
                if (req_valid) begin
                    if (req_write) begin
                        if (wmask_any) begin
                            state_next = S_WRITE;
                        end else begin
                            state_next = S_IDLE;
                        end
                    end else begin
                        state_next = S_READ;
                    end
                    addr_hold_next = req_addr;
                end
            end
            S_READ: begin
                if (mem_ready) begin
                    state_next = S_RESP;
                end
            end
            S_WRITE: begin
                if (mem_ready) begin
                    state_next = S_RESP;
                end
            end
            S_RESP: begin
                rsp_valid = 1'b1;
                if (req_valid && req_ready) begin
                    state_next = req_write ? S_WRITE : S_READ;
                    addr_hold_next = req_addr;
                end
            end
            default: begin
                state_next = S_IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= S_IDLE;
            addr_hold <= '0;
            data_buf  <= '0;
            rsp_rdata <= '0;
        end else begin
            state     <= state_next;
            addr_hold <= addr_hold_next;
            if (state == S_READ && mem_ready) begin
                data_buf <= mem_rdata;
            end
            if (state == S_RESP) begin
                rsp_rdata <= data_buf;
            end
        end
    end

endmodule