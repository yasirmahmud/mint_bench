module unused_param_example_1 (
  input clk,
  input rst,
  input [7:0] data_in,
  output [7:0] data_out
);

  parameter UNUSED_WIDTH = 8; // This parameter is declared but not used

  assign data_out = data_in;

endmodule
