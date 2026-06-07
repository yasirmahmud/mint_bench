module fifo (
  input clk,
  input rst,
  input [31:0] data_in,
  input rd_en,
  input wr_en,
  output [31:0] data_out,
  output full,
  output empty
);
  // Black-box model for linting
  // Fix NoAssignX-ML: Change 'x' to '0'
  assign data_out = {32{1'b0}};
  assign full = 1'b0;
  assign empty = 1'b0;

  // Fix W240: Make sure inputs are read
  reg _clk_dummy_fifo, _rst_dummy_fifo, _rd_en_dummy_fifo, _wr_en_dummy_fifo;
  reg [31:0] _data_in_dummy_fifo;
  always @(*) begin
    _clk_dummy_fifo = clk;
    _rst_dummy_fifo = rst;
    _data_in_dummy_fifo = data_in;
    _rd_en_dummy_fifo = rd_en;
    _wr_en_dummy_fifo = wr_en;
  end
endmodule
