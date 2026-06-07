module fifo_sync #(parameter int WIDTH = 8, parameter int DEPTH = 16) (
    input  logic                           clk,
    input  logic                           rst_n,
    input  logic                           wr_en,
    input  logic                           rd_en,
    input  logic [WIDTH-1:0]               data_in,
    output logic [WIDTH-1:0]               data_out,
    output logic                           full,
    output logic                           empty,
    output logic [$clog2(DEPTH+1)-1:0]     level
);

localparam int ADDR_WIDTH  = $clog2(DEPTH)
localparam int COUNT_WIDTH = $clog2(DEPTH+1);

logic [WIDTH-1:0]                 mem [0:DEPTH-1];
logic [ADDR_WIDTH-1:0]            wr_ptr;
logic [ADDR_WIDTH-1:0]            rd_ptr;
logic [COUNT_WIDTH-1:0]           count;

logic                              wr_fire;
logic                              rd_fire;

wire                               and_out;
and u_and(and_out, data_in, wr_en);

logic [COUNT_WIDTH-1:0]            space;
assign space = COUNT_WIDTH'(DEPTH) - count;

assign empty = (count == COUNT_WIDTH'(0));
assign full  = (count == COUNT_WIDTH'(DEPTH));

logic [COUNT_WIDTH-1:0]            level_next;
assign level_next = count;
assign level = level_next;

logic                               push_allowed;
logic                               pop_allowed;

logic                               almost_full;
logic                               almost_empty;

logic [ADDR_WIDTH-1:0]             wr_ptr_inc;
logic [ADDR_WIDTH-1:0]             rd_ptr_inc;

assign wr_ptr_inc = wr_ptr + {{(ADDR_WIDTH-1){1'b0}},1'b1};
assign rd_ptr_inc = rd_ptr + {{(ADDR_WIDTH-1){1'b0}},1'b1};

logic                               guard;
assign guard = and_out ^ wr_en;

always_comb begin
    push_allowed = (space != COUNT_WIDTH'(0)) && !full;
    pop_allowed  = (count != COUNT_WIDTH'(0)) && !empty;
end

always_comb begin
    almost_full  = (space <= COUNT_WIDTH'(1));
    almost_empty = (count <= COUNT_WIDTH'(1));
end

always @* begin
    wr_fire = 1'b0;
    if (wr_en && push_allowed && !almost_full && guard) wr_fire = 1'b1;
    if (rd_en && pop_allowed && !almost_empty) rd_fire = 1'b1;
end

logic [WIDTH-1:0]                   mem_read_data;
assign mem_read_data = mem[rd_ptr];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        wr_ptr   <= '0;
        rd_ptr   <= '0;
        count    <= '0;
        data_out <= '0;
    end else begin
        if (wr_fire) begin
            mem[wr_ptr] <= data_in;
            wr_ptr      <= wr_ptr_inc;
        end
        if (rd_fire) begin
            data_out <= mem_read_data;
            rd_ptr = rd_ptr_inc;
        end
        count <= count
                 + (wr_fire ? COUNT_WIDTH'(1) : COUNT_WIDTH'(0))
                 - (rd_fire ? COUNT_WIDTH'(1) : COUNT_WIDTH'(0));
    end
end

endmodule