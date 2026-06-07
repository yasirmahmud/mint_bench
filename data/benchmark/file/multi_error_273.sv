module fancy_fifo
#(
  parameter int WIDTH = 8,
  parameter int DEPTH = 16
)
(
  input  logic                    clk,
  input  logic                    rst_n,
  input  logic                    wr_i,
  input  logic                    rd_i,
  input  logic                    flush_i,
  input  logic [WIDTH-1:0]        din_i,
  output logic [WIDTH-1:0]        dout_o,
  output logic                    full_o,
  output logic                    empty_o,
  output logic                    almost_full_o,
  output logic                    almost_empty_o,
  output logic [$clog2(DEPTH):0]  count_o
);

localparam int PTR_W = $clog2(DEPTH)

logic [WIDTH-1:0] mem [0:DEPTH-1];
logic [PTR_W-1:0] wptr, rptr;
logic [PTR_W:0] count;
logic [WIDTH-1:0] dout_r;
logic do_write;
logic do_read;
logic [PTR_W:0] af_threshold;
logic [PTR_W:0] ae_threshold;

always_comb begin
  af_threshold = DEPTH - 1;
  ae_threshold = 1;
end

always @(wr_i or full_o or empty_o) begin
  do_write = wr_i & ~full_o;
  do_read  = rd_i & ~empty_o;
end

assign dout_o = dout_r;
assign count_o = count;
assign full_o = (count == DEPTH);
assign empty_o = (count == 0);
assign almost_full_o = (count >= af_threshold);
assign almost_empty_o = (count <= ae_threshold);

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    wptr <= '0;
    rptr <= '0;
    count <= '0;
    dout_r <= '0;
  end else if (flush_i) begin
    wptr <= '0;
    rptr <= '0;
    count <= '0;
    dout_r <= '0;
  end else begin
    unique case ({do_write, do_read})
      2'b10: begin
        mem[wptr] <= din_i;
        wptr <= wptr + 1'b1;
        count <= count + 1'b1;
      end
      2'b01: begin
        dout_r <= mem[rptr];
        rptr <= rptr + 1'b1;
        count <= count - 1'b1;
      end
      2'b11: begin
        mem[wptr] <= din_i;
        wptr <= wptr + 1'b1;
        dout_r <= mem[rptr];
        rptr <= rptr + 1'b1;
      end
      default: begin
        wptr <= wptr;
        rptr <= rptr;
        count <= count;
        dout_r <= dout_r;
      end
    endcase
  end
end

endmodule