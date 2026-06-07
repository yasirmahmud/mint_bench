module DW_div_pipe (
  input clk,
  input rst_n,
  input en,
  input [71:0] a,
  input [9:0] b,
  output [71:0] quotient,
  output [9:0] remainder,
  output divide_by_0
);
  // Black-box model for linting
  // Fix NoAssignX-ML: Change 'x' to '0'
  assign quotient = {72{1'b0}};
  assign remainder = {10{1'b0}};
  assign divide_by_0 = 1'b0;

  // Fix W240: Make sure inputs are read
  reg _clk_dummy_div, _rst_n_dummy_div, _en_dummy_div;
  reg [71:0] _a_dummy_div;
  reg [9:0] _b_dummy_div;
  always @(*) begin
    _clk_dummy_div = clk;
    _rst_n_dummy_div = rst_n;
    _en_dummy_div = en;
    _a_dummy_div = a;
    _b_dummy_div = b;
  end
endmodule
