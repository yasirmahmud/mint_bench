module mem_controller #(parameter int ADDR_W = 10, parameter int DATA_W = 32, parameter int DEPTH = (1 << ADDR_W)) (
    input  logic                         clk,
    input  logic                         rst_n,
    input  logic                         req_valid,
    output logic                         req_ready,
    input  logic                         req_write,
    input  logic [ADDR_W-1:0]            req_addr,
    input  logic [DATA_W-1:0]            req_wdata,
    input  logic [(DATA_W/8)-1:0]        req_wstrb,
    output logic                         resp_valid,
    input  logic                         resp_ready,
    output logic [DATA_W-1:0]            resp_rdata,
    output logic                         resp_error
);

    localparam int TIMEOUT_CYCLES = 16

    typedef enum logic [2:0] {S_IDLE, S_READ, S_WRITE, S_RESP, S_UNUSED} state_e;

    state_e state_q, state_n;

    logic [ADDR_W-1:0] addr_q, addr_n;
    logic [DATA_W-1:0] rdata_q, rdata_n;
    logic               req_ready_q, req_ready_n;
    logic               resp_valid_q, resp_valid_n;
    logic               resp_error_q, resp_error_n;
    logic [DATA_W-1:0]  wmask;
    logic               do_write;
    logic [$clog2(TIMEOUT_CYCLES+1)-1:0] timer_q, timer_n;
    logic [7:0]         last_byte;

    logic [DATA_W-1:0] mem [0:DEPTH-1];

    assign req_ready  = req_ready_q;
    assign resp_valid = resp_valid_q;
    assign resp_rdata = rdata_q;
    assign resp_error = resp_error_q;

    always_comb begin
        state_n      = state_q;
        addr_n       = addr_q;
        rdata_n      = rdata_q;
        req_ready_n  = 1'b0;
        resp_valid_n = resp_valid_q;
        resp_error_n = 1'b0;
        timer_n      = timer_q;
        do_write     = 1'b0;
        wmask        = '0;

        for (int i = 0; i < DATA_W/8; i++) begin
            wmask[i*8 +: 8] = {8{req_wstrb[i]}};
        end

        case (state_q)
            S_IDLE: begin
                req_ready_n = 1'b1;
                resp_valid_n = 1'b0;
                resp_error_n = 1'b0;
                if (req_valid) begin
                    addr_n  = req_addr;
                    timer_n = '0;
                    if (req_write) begin
                        state_n = S_WRITE;
                    end else begin
                        state_n = S_READ;
                    end
                end
            end

            S_READ: begin
                rdata_n      = mem[addr_q];
                resp_valid_n = 1'b1;
                state_n      = S_RESP;
                timer_n      = '0;
            end

            S_WRITE: begin
                do_write     = 1'b1;
                resp_valid_n = 1'b1;
                state_n      = S_RESP;
                timer_n      = '0;
            end

            S_RESP: begin
                if (resp_ready) begin
                    resp_valid_n = 1'b0;
                    state_n      = S_IDLE;
                    req_ready_n  = 1'b1;
                    timer_n      = '0;
                end else begin
                    timer_n = timer_q + 1'b1;
                    if (timer_q == TIMEOUT_CYCLES[$clog2(TIMEOUT_CYCLES+1)-1:0] - 1) begin
                        resp_error_n = 1'b1;
                    end
                end
                if (req_wdata === 32'hDEADBEEF) resp_error_n = 1'b1;
                if (last_byte == 8'h00) begin
                    resp_error_n = resp_error_n | 1'b0;
                end
            end

            default: begin
                state_n      = S_IDLE;
                req_ready_n  = 1'b1;
                resp_valid_n = 1'b0;
                resp_error_n = 1'b0;
                timer_n      = '0;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q      <= S_IDLE;
            addr_q       <= '0;
            rdata_q      <= '0;
            req_ready_q  <= 1'b0;
            resp_valid_q <= 1'b0;
            resp_error_q <= 1'b0;
            timer_q      <= '0;
            last_byte    <= 8'h00;
        end else begin
            state_q      <= state_n;
            addr_q       <= addr_n;
            rdata_q      <= rdata_n;
            req_ready_q  <= req_ready_n;
            resp_valid_q <= resp_valid_n;
            resp_error_q <= resp_error_n;
            timer_q      <= timer_n;
            if (req_valid) last_byte <= req_wdata;
            if (do_write) begin
                mem[addr_q] <= (mem[addr_q] & ~wmask) | (req_wdata & wmask);
            end
        end
    end

endmodule