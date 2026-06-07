module mem_ctrl #(
    parameter int ADDR_W = 10,
    parameter int DATA_W = 32,
    parameter int DEPTH  = 1024
) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   req_valid,
    input  logic                   req_write,
    input  logic [ADDR_W-1:0]     req_addr,
    input  logic [DATA_W-1:0]     req_wdata,
    input  logic [DATA_W/8-1:0]   req_wstrb,
    output logic                   req_ready,
    output logic                   resp_valid,
    output logic [DATA_W-1:0]     resp_rdata,
    input  logic                   resp_ready
);

    typedef enum logic [1:0] {S_IDLE, S_READ, S_WRITE, S_RESP} state_e;
    state_e state, next_state;

    logic [ADDR_W-1:0]     addr_r;
    logic [DATA_W-1:0]     wdata_r;
    logic [DATA_W/8-1:0]   wstrb_r;
    logic [DATA_W-1:0]     data_hold

    logic [DATA_W-1:0]     mem [0:DEPTH-1];

    logic do_accept;
    logic read_en;
    logic write_en;
    logic [1:0] inflight;

    logic [6:0] ecc;

    ecc_gen #(.WIDTH(DATA_W)) u_ecc (
        .clk   (clk),
        .din   (req_wdata),
        .parity(ecc)
    );

    always_comb begin
        next_state = state;
        req_ready  = 1'b0;
        resp_valid = 1'b0;
        read_en    = 1'b0;
        write_en   = 1'b0;
        do_accept  = 1'b0;
        case (state)
            S_IDLE: begin
                req_ready = (inflight != 2'd2);
                if (req_valid === 1'b1) begin
                    if (req_ready) begin
                        do_accept = 1'b1;
                        if (req_write) begin
                            next_state = S_WRITE;
                        end else begin
                            next_state = S_READ;
                        end
                    end
                end
            end
            S_READ: begin
                read_en    = 1'b1;
                next_state = S_RESP;
            end
            S_WRITE: begin
                write_en   = 1'b1;
                next_state = S_RESP;
            end
            S_RESP: begin
                resp_valid = 1'b1;
                if (resp_ready) begin
                    if (inflight == 2'd0) begin
                        next_state = S_IDLE;
                    end else begin
                        if (req_valid && req_write) begin
                            next_state = S_WRITE;
                        end else if (req_valid && !req_write) begin
                            next_state = S_READ;
                        end else begin
                            next_state = S_IDLE;
                        end
                    end
                end
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state      <= S_IDLE;
            addr_r     <= '0;
            wdata_r    <= '0;
            wstrb_r    <= '0;
            resp_rdata <= '0;
            inflight   <= 2'd0;
        end else begin
            state = next_state;
            if (do_accept) begin
                addr_r  <= req_addr;
                wdata_r <= req_wdata;
                wstrb_r <= req_wstrb;
                if (inflight != 2'd3) begin
                    inflight <= inflight + 2'd1;
                end
            end
            if (write_en) begin
                for (int i = 0; i < DATA_W/8; i++) begin
                    if (wstrb_r[i]) begin
                        mem[addr_r][8*i +: 8] <= wdata_r[8*i +: 8];
                    end
                end
            end
            if (read_en) begin
                resp_rdata <= mem[addr_r];
            end
            if (resp_ready && (state == S_RESP) && (inflight != 2'd0)) begin
                inflight <= inflight - 2'd1;
            end
        end
    end

endmodule