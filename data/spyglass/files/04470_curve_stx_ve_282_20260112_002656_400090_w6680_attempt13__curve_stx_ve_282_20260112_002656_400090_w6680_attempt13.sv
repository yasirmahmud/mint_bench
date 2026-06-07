module curve_stx_ve_282_20260112_002656_400090_w6680_attempt13 (
  input clk,
  input [7:0] top_in_0,
  output [7:0] top_out_0,
  input [7:0] top_in_1,
  output [7:0] top_out_1
);

  // This instance triggers the first STX_VE_282 violation.
  // The named port 'unknown_input_port' does not exist in 'my_sub_module'.
  my_sub_module i_sub_instance_0 (
    .sub_clk                  (clk),
    .sub_data_in              (top_in_0),
    .unknown_input_port       (top_in_0), // Violation 1: Port 'unknown_input_port' not found in 'my_sub_module'
    .sub_data_out             (top_out_0)
  );

  // This instance triggers the second STX_VE_282 violation.
  // The named port 'non_existent_output' does not exist in 'my_sub_module'.
  my_sub_module i_sub_instance_1 (
    .sub_clk                  (clk),
    .sub_data_in              (top_in_1),
    .sub_data_out             (top_out_1),
    .non_existent_output      (top_out_1) // Violation 2: Port 'non_existent_output' not found in 'my_sub_module'
  );

endmodule
