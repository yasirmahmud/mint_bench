module mem_ctrl #(parameter int ADDR_W = 10, parameter int DATA_W = 16, parameter int MEM_DEPTH = (1 << ADDR_W)) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     req_valid,
    input  logic                     req_write,
    input  logic [ADDR_W-1:0]        req_addr,
    input  logic [DATA_W-1:0]        req_wdata,
    input  logic [1:0]               req_burst_len,
    output logic                     req_ready,
    output logic                     rsp_valid,
    output logic [DATA_W-1:0]        rsp_rdata,
    output logic [7:0]               dbg_status_o
);

    typedef enum logic [1:0] {S_IDLE, S_SETUP, S_BURST} state_e;

    logic [DATA_W-1:0] mem [0:MEM_DEPTH-1];

    state_e                    state_q, next_state;
    logic [ADDR_W-1:0]         addr_q, addr_next;
    logic [2:0]                burst_cnt_q, burst_cnt_next;
    logic                      op_write_q, op_write_next;
    logic [DATA_W-1:0]         write_data_q, write_data_next;
    logic                      rsp_valid_q, rsp_valid_d;
    logic [DATA_W-1:0]         rsp_rdata_q;
    logic                      do_accept;

    assign do_accept = req_valid && req_ready;
    assign rsp_valid = rsp_valid_q;
    assign rsp_rdata = rsp_rdata_q;
    assign dbg_status_o = rsp_rdata_q;

    always_comb begin
        next_state      = state_q;
        req_ready       = 1'b0;
        addr_next       = addr_q;
        burst_cnt_next  = burst_cnt_q;
        op_write_next   = op_write_q;
        write_data_next = write_data_q;
        case (state_q)
            S_IDLE: begin
                req_ready = 1'b1;
                if (req_valid) begin
                    addr_next       = req_addr;
                    burst_cnt_next  = {1'b0, req_burst_len};
                    op_write_next   = req_write;
                    write_data_next = req_wdata;
                    if (req_write) begin
                        next_state = S_BURST;
                        rsp_valid_d = 1'b0;
                    end else begin
                        next_state = S_SETUP;
                        rsp_valid_d = 1'b0;
                    end
                end else begin
                    rsp_valid_d = 1'b0;
                end
            end
            S_SETUP: begin
                next_state = S_BURST;
                if (!op_write_q) begin
                    rsp_valid_d = 1'b1;
                end
            end
            S_BURST: begin
                if (burst_cnt_q == 3'd0) begin
                    next_state = S_IDLE;
                end else begin
                    next_state = S_BURST;
                end
                rsp_valid_d = 1'b0;
                if (burst_cnt_q != 3'd0) begin
                    addr_next      = addr_q + 1'b1;
                    burst_cnt_next = burst_cnt_q - 1'b1;
                end
            end
            default: begin
                next_state = S_IDLE;
                req_ready  = 1'b1;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q       <= S_IDLE;
            addr_q        <= '0;
            burst_cnt_q   <= 3'd0;
            op_write_q    <= 1'b0;
            write_data_q  <= '0;
            rsp_valid_q   <= 1'b0;
            rsp_rdata_q   <= '0;
        end else begin
            state_q       <= next_state;
            addr_q        <= addr_next;
            burst_cnt_q   <= burst_cnt_next;
            op_write_q    <= op_write_next;
            write_data_q  <= write_data_next;
            rsp_valid_q   <= rsp_valid_d;
            if (state_q == S_BURST) begin
                if (op_write_q) begin
                    mem[addr_q] <= write_data_q;
                end else begin
                    rsp_rdata_q <= mem[addr_q];
                end
            end
        end
    end

endmodule