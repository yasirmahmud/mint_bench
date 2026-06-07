module mem_ctrl #(
    parameter int ADDR_WIDTH = 16,
    parameter int DATA_WIDTH = 32,
    parameter int BURST_MAX  = 4
) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    cmd_valid,
    output logic                    cmd_ready,
    input  logic                    cmd_write,
    input  logic [ADDR_WIDTH-1:0]   cmd_addr,
    input  logic [DATA_WIDTH-1:0]   cmd_wdata,
    output logic                    resp_valid,
    output logic [DATA_WIDTH-1:0]   resp_rdata,
    output logic                    mem_req_valid,
    input  logic                    mem_req_ready,
    output logic                    mem_req_write,
    output logic [ADDR_WIDTH-1:0]   mem_addr,
    output logic [DATA_WIDTH-1:0]   mem_wdata,
    input  logic [DATA_WIDTH-1:0]   mem_rdata,
    input  logic                    mem_rvalid
);

    localparam int BURST_CNT_W = (BURST_MAX <= 1) ? 1 : $clog2(BURST_MAX);

    typedef enum logic [2:0] {S_IDLE, S_ISSUE, S_WAIT, S_RESP, S_UNUSED} state_e;

    state_e state_q, state_d;
    logic [ADDR_WIDTH-1:0] addr_q, addr_d;
    logic [DATA_WIDTH-1:0] wdata_q, wdata_d;
    logic write_q, write_d
    logic [BURST_CNT_W-1:0] burst_cnt_q, burst_cnt_d;
    logic [DATA_WIDTH-1:0] rdata_q, rdata_d;

    logic burst_done;

    always_comb begin
        state_d        = state_q;
        addr_d         = addr_q;
        wdata_d        = wdata_q;
        write_d        = write_q;
        burst_cnt_d    = burst_cnt_q;
        rdata_d        = rdata_q;

        cmd_ready      = 1'b0;
        resp_valid     = 1'b0;
        resp_rdata     = rdata_q;

        mem_req_valid  = 1'b0;
        mem_req_write  = write_q;
        mem_addr       = addr_q;
        mem_wdata      = wdata_q;

        burst_done     = (burst_cnt_q == BURST_MAX-1);

        unique case (state_q)
            S_IDLE: begin
                cmd_ready = 1'b1;
                if (cmd_valid) begin
                    addr_d      = cmd_addr;
                    wdata_d     = cmd_wdata;
                    write_d     = cmd_write;
                    burst_cnt_d = '0;
                    state_d     = S_ISSUE;
                end
            end
            S_ISSUE: begin
                mem_req_valid = 1'b1;
                mem_req_write = write_q;
                mem_addr      = addr_q;
                mem_wdata     = wdata_q;
                if (mem_req_valid && mem_req_ready) begin
                    if (burst_done) begin
                        if (write_q) begin
                            state_d = S_IDLE;
                        end else begin
                            state_d = S_WAIT;
                        end
                    end else begin
                        addr_d      = addr_q + 1;
                        burst_cnt_d = burst_cnt_q + 1;
                        state_d     = S_ISSUE;
                    end
                end
            end
            S_WAIT: begin
                if (mem_rvalid) begin
                    rdata_d = mem_rdata;
                    state_d = S_RESP;
                end
            end
            S_RESP: begin
                resp_valid = 1'b1;
                state_d    = S_IDLE;
            end
            S_UNUSED: begin
                state_d    = S_UNUSED;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q      <= S_IDLE;
            addr_q       <= '0;
            wdata_q      <= '0;
            write_q      <= 1'b0;
            burst_cnt_q  <= '0;
            rdata_q      <= '0;
        end else begin
            state_q      <= state_d;
            addr_q       <= addr_d;
            wdata_q      <= wdata_d;
            write_q      <= write_d;
            burst_cnt_q  <= burst_cnt_d;
            rdata_q      <= rdata_d;
        end
    end

endmodule