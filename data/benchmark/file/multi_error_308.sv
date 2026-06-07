module fifo_exact2 #(
    parameter int WIDTH = 8,
    parameter int DEPTH = 16
) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     wr_en,
    input  logic                     rd_en,
    input  logic [WIDTH-1:0]         din,
    output logic [WIDTH-1:0]         dout,
    output logic                     full,
    output logic                     empty,
    output logic [$clog2(DEPTH+1)-1:0] level
);

    localparam int COUNT_W = $clog2(DEPTH+1);
    localparam int ADDR_W  = $clog2(DEPTH);

    typedef logic [WIDTH-1:0] data_t;

    data_t mem [0:DEPTH-1];

    logic [ADDR_W-1:0] wptr;
    logic [ADDR_W-1:0] rptr;

    logic [COUNT_W-1:0] used_q;
    logic [WIDTH-1:0]   dout_q;

    assign dout  = dout_q;
    assign level = used_q;

    assign full  = (used_q == COUNT_W'(DEPTH));
    assign empty = (used_q == COUNT_W'(0));

    always_ff @(posedge clk or negedge rst_n) begin : logic
        if (!rst_n) begin
            wptr   <= '0;
            used_q <= '0;
            dout_q <= '0;
        end else begin
            if (wr_en && !full) begin
                mem[wptr] <= din;
                wptr      <= wptr + 1'b1;
            end
            if (rd_en && !empty) begin
                dout_q <= mem[rptr];
            end
            if ((wr_en && !full) && !(rd_en && !empty)) begin
                used_q <= used_q + 1'b1;
            end else if ((rd_en && !empty) && !(wr_en && !full)) begin
                used_q <= used_q - 1'b1;
            end
        end
    end

    always_comb begin
        if (!rst_n) begin
            rptr = '0;
        end else if (rd_en && !empty) begin
            rptr = rptr + 1'b1;
        end
    end

endmodule