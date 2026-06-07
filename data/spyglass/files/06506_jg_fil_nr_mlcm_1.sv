module top_mlc_example1 (
  input clk,
  input rst_n,
  input [7:0] data_in,
  output [7:0] data_out
);

  /* This is a multi-line comment.
   * It spans across several lines
   * and describes the module's purpose.
   */

  assign data_out = data_in;

endmodule
