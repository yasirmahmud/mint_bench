module my_design_a #(
  parameter DATA_WIDTH = 8 // Violates naming convention (e.g., if expected to end with _par)
) (
  input clk,
  input rst,
  input [DATA_WIDTH-1:0] in_data,
  output [DATA_WIDTH-1:0] out_data
);

  assign out_data = in_data;

endmodule
