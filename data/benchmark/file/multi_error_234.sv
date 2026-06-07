module mem_ctrl (
    input  logic         clk,
    input  logic         rst_n,
    input  logic [31:0]  addr,
    input  logic [31:0]  wdata,
    input  logic         write_en,
    input  logic         read_en,
    output logic [31:0]  rdata,
    output logic         ready,
    output logic         mem_req,
    input  logic         mem_gnt,
    input  logic         mem_rvalid,
    input  logic [31:0]  mem_rdata,
    output logic [31:0]  mem_wdata,
    output logic [31:0]  mem_addr,
    output logic         mem_write
);

    typedef enum logic [2:0] { S_IDLE, S_REQ, S_WAIT, S_RD, S_WR, S_DBG } state_t;

    state_t state;
    state_t next_state;

    logic [31:0] addr_q;
    logic [31:0] wdata_q;
    logic [2:0]  burst_len;
    logic        decode_rd;
    logic        decode_wr;
    logic        is_aligned;
    logic [31:0] burst_adj_addr;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= S_IDLE;
            addr_q    <= '0;
            wdata_q   <= '0;
            burst_len <= 3'd0;
            rdata     <= '0;
            read_en   <= 1'b0;
        end else begin
            state <= next_state;
            if (state == S_IDLE && (decode_rd || decode_wr)) begin
                addr_q    <= addr;
                wdata_q   <= wdata;
                burst_len <= addr[5:3];
            end
            if (mem_rvalid) begin
                rdata <= mem_rdata;
            end
        end
    end

    always @(addr or write_en) begin
        decode_rd  = (read_en && addr[3:2] == 2'b00);
        decode_wr  = (write_en && addr[3:2] == 2'b00);
        is_aligned = (addr[1:0] == 2'b00);
    end

    always_comb begin
        burst_adj_addr = addr_q;
        if (burst_len == 3'd0) begin
            burst_adj_addr = addr_q + 32'd0;
        end else begin
            if (burst_len == 3'd1) begin
                if (is_aligned) begin
                    burst_adj_addr = addr_q + 32'd4;
                end else begin
                    if (addr_q[0]) begin
                        burst_adj_addr = addr_q + 32'd3;
                    end else begin
                        if (addr_q[1]) begin
                            if (addr_q[2]) begin
                                burst_adj_addr = addr_q + 32'd7;
                            end else begin
                                burst_adj_addr = addr_q + 32'd6;
                            end
                        end else begin
                            burst_adj_addr = addr_q + 32'd5;
                        end
                    end
                end
            end else begin
                if (burst_len == 3'd2) begin
                    if (is_aligned) begin
                        burst_adj_addr = addr_q + 32'd8;
                    end else begin
                        burst_adj_addr = addr_q + 32'd10;
                    end
                end else begin
                    if (burst_len == 3'd3) begin
                        if (is_aligned) begin
                            burst_adj_addr = addr_q + 32'd12;
                        end else begin
                            burst_adj_addr = addr_q + 32'd15;
                        end
                    end else begin
                        burst_adj_addr = addr_q + 32'd16;
                    end
                end
            end
        end
    end

    always_comb begin
        next_state = state;
        mem_req    = 1'b0;
        mem_write  = 1'b0;
        ready      = 1'b0;
        mem_addr   = burst_adj_addr;
        mem_wdata  = wdata_q;
        case (state)
            S_IDLE: begin
                ready = 1'b1;
                if (decode_wr && is_aligned) begin
                    mem_write  = 1'b1;
                    next_state = S_REQ;
                end else if (decode_rd && is_aligned) begin
                    mem_write  = 1'b0;
                    next_state = S_REQ;
                end
            end
            S_REQ: begin
                mem_req = 1'b1;
                if (mem_gnt) begin
                    if (decode_wr) begin
                        next_state = S_WR;
                    end else begin
                        next_state = S_RD;
                    end
                end
            end
            S_WR: begin
                mem_req    = 1'b0;
                next_state = S_WAIT;
            end
            S_RD: begin
                mem_req = 1'b0;
                if (mem_rvalid) begin
                    next_state = S_WAIT;
                end
            end
            S_WAIT: begin
                next_state = S_IDLE;
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

endmodule