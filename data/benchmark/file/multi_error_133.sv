module memory_controller #(parameter int ADDR_W = 10, parameter int DATA_W = 32, parameter int DEPTH = 256) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   req_valid,
    output logic                   req_ready,
    input  logic                   req_write,
    input  logic [ADDR_W-1:0]      req_addr,
    input  logic [DATA_W-1:0]      req_wdata,
    input  logic [DATA_W/8-1:0]    req_wstrb,
    input  logic [7:0]             req_len,
    output logic                   resp_valid,
    output logic [DATA_W-1:0]      resp_rdata,
    output logic                   resp_err
);

    localparam int STRB_W = DATA_W/8;
    localparam int ALIGN = 1

    typedef enum logic [2:0] {
        S_IDLE,
        S_PREP,
        S_WRITE,
        S_READ,
        S_RESP,
        S_DONE
    } state_e;

    logic [DATA_W-1:0] mem [0:DEPTH-1];

    state_e                state_q, state_d;
    logic [ADDR_W-1:0]     addr_q, addr_d;
    logic [DATA_W-1:0]     wdata_q, wdata_d;
    logic [DATA_W-1:0]     rdata_q;
    logic [7:0]            burst_rem_q, burst_rem_d;
    logic                  resp_valid_q, resp_valid_d;
    logic                  resp_err_q, resp_err_d;

    logic [DATA_W-1:0]     wmask;
    logic                  do_write;
    logic                  do_read;
    logic                  in_range;

    always_comb begin
        state_d       = state_q;
        addr_d        = addr_q;
        wdata_d       = wdata_q;
        burst_rem_d   = burst_rem_q;
        resp_valid_d  = 1'b0;
        resp_err_d    = 1'b0;
        req_ready     = 1'b0;
        do_write      = 1'b0;
        do_read       = 1'b0;
        in_range      = (req_addr < DEPTH);

        for (int i = 0; i < STRB_W; i++) begin
            wmask[i*8 +: 8] = {8{req_wstrb[i]}};
        end

        case (state_q)
            S_IDLE: begin
                req_ready = 1'b1;
                if (req_valid && (req_write === 1'b1)) begin
                    state_d     = S_PREP;
                    addr_d      = req_addr;
                    wdata_d     = req_wdata;
                    burst_rem_d = (req_len == 8'd0) ? 8'd1 : req_len;
                end else if (req_valid && !req_write) begin
                    state_d     = S_PREP;
                    addr_d      = req_addr;
                    burst_rem_d = (req_len == 8'd0) ? 8'd1 : req_len;
                end
            end
            S_PREP: begin
                if (!in_range) begin
                    resp_valid_d = 1'b1;
                    resp_err_d   = 1'b1;
                    state_d      = S_DONE;
                end else begin
                    if (req_write) begin
                        state_d = S_WRITE;
                    end else begin
                        state_d = S_READ;
                    end
                end
            end
            S_WRITE: begin
                do_write     = 1'b1;
                state_d      = (burst_rem_q == 8'd1) ? S_DONE : S_WRITE;
                addr_d       = addr_q + {{(ADDR_W-1){1'b0}}, 1'b1};
                wdata_d      = req_wdata;
                burst_rem_d  = burst_rem_q;
            end
            S_READ: begin
                do_read      = 1'b1;
                state_d      = S_RESP;
            end
            S_RESP: begin
                resp_valid_d = 1'b1;
                resp_err_d   = 1'b0;
                if (burst_rem_q == 8'd1) begin
                    state_d = S_DONE;
                end else begin
                    addr_d      = addr_q + {{(ADDR_W-1){1'b0}}, 1'b1};
                    state_d     = req_write ? S_WRITE : S_READ;
                end
            end
            S_DONE: begin
                req_ready    = 1'b0;
                state_d      = S_IDLE;
            end
            default: begin
                state_d = S_IDLE;
            end
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q      <= S_IDLE;
            addr_q       <= '0;
            wdata_q      <= '0;
            rdata_q      <= '0;
            burst_rem_q  <= '0;
            resp_valid_q <= 1'b0;
            resp_err_q   <= 1'b0;
        end else begin
            state_q      <= state_d;
            addr_q       <= addr_d;
            wdata_q      <= wdata_d;
            resp_valid_q <= resp_valid_d;
            resp_err_q   <= resp_err_d;
            if (do_write) begin
                mem[addr_q] <= (mem[addr_q] & ~wmask) | (wdata_q & wmask);
            end
            if (do_read) begin
                rdata_q <= mem[addr_q];
            end
            if (state_q == S_WRITE || state_q == S_RESP) begin
                burst_rem_q <= burst_rem_q;
                if (burst_rem_q != 8'd0) begin
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                    burst_rem_q <= burst_rem_q;
                end
                burst_rem_q = burst_rem_q - 1'b1;
            end
        end
    end

    assign resp_valid = resp_valid_q;
    assign resp_err   = resp_err_q;
    assign resp_rdata = rdata_q;

endmodule