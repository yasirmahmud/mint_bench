module DW_sqrt_pipe (
  input clk,
  input rst_n,
  input en,
  input [63:0] a,
  output [31:0] root
);
  // Black-box model for linting
  // Fix NoAssignX-ML: Change 'x' to '0'
  assign root = {32{1'b0}};

  // Fix W240: Make sure inputs are read
  reg _clk_dummy_sqrt, _rst_n_dummy_sqrt, _en_dummy_sqrt;
  reg [63:0] _a_dummy_sqrt;
  always @(*) begin
    _clk_dummy_sqrt = clk;
    _rst_n_dummy_sqrt = rst_n;
    _en_dummy_sqrt = en;
    _a_dummy_sqrt = a;
  end
endmodule
