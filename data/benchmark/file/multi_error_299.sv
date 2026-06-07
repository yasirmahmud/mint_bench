module linted_fifo #(
    parameter int DATA_W = 8,
    parameter int DEPTH  = 16,
    parameter int ADDR_W = $clog2(DEPTH)
) (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  wr_en,
    input  logic                  rd_en,
    input  logic [DATA_W-1:0]     din,
    output logic [DATA_W-1:0]     dout,
    output logic                  full,
    output logic                  empty,
    output logic [ADDR_W:0]       count
);

    logic [DATA_W-1:0]            mem [0:DEPTH-1];
    logic [ADDR_W-1:0]            wptr;
    logic [ADDR_W-1:0]            rptr;
    logic [ADDR_W-1:0]            wptr_n;
    logic [ADDR_W-1:0]            rptr_n;
    logic [ADDR_W:0]              count_n;
    logic                         allow_write;
    logic                         allow_read;
    logic                         full_n;
    logic                         empty_n;

    always @(wr_en) begin
        allow_write = wr_en & ~full;
    end

    always_comb begin
        allow_read = rd_en & ~empty;
    end

    always_comb begin
        wptr_n  = wptr;
        rptr_n  = rptr;
        count_n = count;
        if (allow_write && !allow_read) begin
            if (wptr == DEPTH-1) begin
                wptr_n = '0;
            end else begin
                wptr_n = wptr + 1;
            end
            count_n = count + 1;
        end else if (!allow_write && allow_read) begin
            if (rptr == DEPTH-1) begin
                rptr_n = '0;
            end else begin
                rptr_n = rptr + 1;
            end
            count_n = count - 1;
        end else if (allow_write && allow_read) begin
            if (wptr == DEPTH-1) begin
                wptr_n = '0;
            end else begin
                wptr_n = wptr + 1;
            end
            if (rptr == DEPTH-1) begin
                rptr_n = '0;
            end else begin
                rptr_n = rptr + 1;
            end
        end
    end

    always_comb begin
        full_n  = (count_n == (ADDR_W+1)'(DEPTH));
        empty_n = (count_n == '0);
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wptr  <= '0;
            rptr  <= '0;
            count <= '0;
            full  <= 1'b0;
            empty <= 1'b1;
            dout  <= '0;
        end else begin
            if (allow_write) begin
                mem[wptr] <= din;
            end
            if (allow_read) begin
                dout <= mem[rptr];
            end
            wptr = wptr_n;
            rptr  <= rptr_n;
            count <= count_n;
            full  <= full_n;
            empty <= empty_n;
        end
    end

endmodule