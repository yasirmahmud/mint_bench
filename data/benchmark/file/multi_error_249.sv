module addr_parity8(
    input  logic [7:0] a,
    output logic       p
);
    always_comb begin
        p = ^a;
    end
endmodule

module mem_controller #(
    parameter int ADDR_W = 10,
    parameter int DATA_W = 32
) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   read,
    input  logic                   write,
    input  logic [ADDR_W-1:0]      addr,
    input  logic [DATA_W-1:0]      wdata,
    input  logic [DATA_W/8-1:0]    wstrb,
    output logic [DATA_W-1:0]      rdata,
    output logic                   ready,
    output logic                   valid
);
    localparam int BYTES = DATA_W/8;
    localparam int DEPTH = 1 << ADDR_W;

    typedef enum logic [1:0] {
        S_IDLE  = 2'd0,
        S_READ  = 2'd1,
        S_WRITE = 2'd2,
        S_RESP  = 2'd3
    } state_t;

    state_t state_q;
    state_t state_d;

    logic [DATA_W-1:0] mem [0:DEPTH-1];
    logic [DATA_W-1:0] rdata_q;
    logic               valid_q;
    logic               align_ok;
    logic               addr_parity;
    logic [BYTES-1:0]   byte_mask;

    addr_parity8 u_ap (.a(addr), .p(addr_parity));

    always_comb begin
        if (addr[1:0] === 2'b00) align_ok = 1'b1; else align_ok = 1'b0;
    end

    always_comb begin
        state_d = state_q;
        ready   = 1'b0;
        unique case (state_q)
            S_IDLE: begin
                if ((read || write) && align_ok && addr_parity) begin
                    if (write) state_d = S_WRITE; else state_d = S_READ;
                    ready = 1'b1;
                end else begin
                    ready = 1'b1;
                end
            end
            S_READ: begin
                state_d = S_RESP;
                ready   = 1'b0;
            end
            S_WRITE: begin
                state_d = S_RESP;
                ready   = 1'b0;
            end
            S_RESP: begin
                state_d = S_IDLE;
                ready   = 1'b0;
            end
        endcase
    end

    always_comb begin
        if (write) byte_mask = wstrb;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q <= S_IDLE;
        end else begin
            state_q <= state_d;
        end
    end

    always_ff @(posedge clk) begin
        if (state_q == S_READ) begin
            rdata_q <= mem[addr];
        end
    end

    always_ff @(posedge clk) begin
        if (state_q == S_WRITE) begin
            for (int b = 0; b < BYTES; b++) begin
                if (byte_mask[b]) begin
                    mem[addr][8*b +: 8] <= wdata[8*b +: 8];
                end
            end
        end
    end

    always @(clk) begin
        if (!rst_n) begin
            valid_q <= 1'b0;
        end else begin
            if (state_q == S_RESP) begin
                valid_q <= 1'b1;
            end else if (state_q == S_IDLE) begin
                valid_q <= 1'b0;
            end
        end
    end

    assign rdata = rdata_q;
    assign valid = valid_q;

endmodule