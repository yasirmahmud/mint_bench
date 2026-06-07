module fifo_with_two_errors
#(
    parameter int WIDTH = 16,
    parameter int DEPTH = 16
)
(
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   wr_en,
    input  logic                   rd_en,
    input  logic [WIDTH-1:0]       din,
    output logic [WIDTH-1:0]       dout,
    output logic                   full,
    output logic                   empty,
    output logic [7:0]             dbg_narrow
);

localparam int ADDR_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH);
localparam int CNT_W  = $clog2(DEPTH + 1);
localparam logic [ADDR_W-1:0] LAST_IDX   = logic [ADDR_W-1:0]'(DEPTH - 1);
localparam logic [ADDR_W-1:0] ONE_ADDR   = logic [ADDR_W-1:0]'(1);
localparam logic [CNT_W-1:0]  MAX_COUNT  = logic [CNT_W-1:0]'(DEPTH);
localparam logic [CNT_W-1:0]  ONE_COUNT  = logic [CNT_W-1:0]'(1);
localparam logic [CNT_W-1:0]  ZERO_COUNT = logic [CNT_W-1:0]'(0);

logic [WIDTH-1:0] mem [0:DEPTH-1];

logic [ADDR_W-1:0] wr_ptr;
logic [ADDR_W-1:0] rd_ptr;

logic [ADDR_W-1:0] next_wr_ptr;
logic [ADDR_W-1:0] next_rd_ptr;

logic [CNT_W-1:0]  count;
logic [CNT_W-1:0]  next_count;

logic [WIDTH-1:0]  dout_reg;
logic [WIDTH-1:0]  next_dout_reg;

assign dout = dout_reg;

assign dbg_narrow = dout_reg;

always_comb begin
    next_wr_ptr   = wr_ptr;
    next_count    = count;
    next_dout_reg = dout_reg;
    if (wr_en && (count != MAX_COUNT) && !(rd_en && (count != ZERO_COUNT))) begin
        next_wr_ptr = (wr_ptr == LAST_IDX) ? '0 : wr_ptr + ONE_ADDR;
        next_count  = count + ONE_COUNT;
    end
    else if (rd_en && (count != ZERO_COUNT) && !(wr_en && (count != MAX_COUNT))) begin
        next_count  = count - ONE_COUNT;
    end
    else if (wr_en && (count != MAX_COUNT) && rd_en && (count != ZERO_COUNT)) begin
        next_count  = count;
    end
    if (rd_en && (count != ZERO_COUNT)) begin
        next_dout_reg = mem[rd_ptr];
    end
end

always_comb begin
    if (rd_en && (count != ZERO_COUNT)) begin
        next_rd_ptr = (rd_ptr == LAST_IDX) ? '0 : rd_ptr + ONE_ADDR;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        wr_ptr    <= '0;
        rd_ptr    <= '0;
        count     <= '0;
        full      <= 1'b0;
        empty     <= 1'b1;
        dout_reg  <= '0;
    end else begin
        wr_ptr    <= next_wr_ptr;
        rd_ptr    <= next_rd_ptr;
        count     <= next_count;
        full      <= (next_count == MAX_COUNT);
        empty     <= (next_count == ZERO_COUNT);
        dout_reg  <= next_dout_reg;
        if (wr_en && !full) begin
            mem[wr_ptr] <= din;
        end
    end
end

endmodule