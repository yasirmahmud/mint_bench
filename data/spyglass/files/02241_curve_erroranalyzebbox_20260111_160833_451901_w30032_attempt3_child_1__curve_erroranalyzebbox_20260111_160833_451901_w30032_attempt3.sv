module curve_erroranalyzebbox_20260111_160833_451901_w30032_attempt3 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output wire data_out
);

  wire processed_data;

  // Instantiating 'my_blackbox_unit' without providing its definition
  // will cause SpyGlass to infer it as a black-box, triggering ErrorAnalyzeBBox.
  my_blackbox_unit U_processor (
    .clock(clk),
    .reset(rst_n),
    .input_data(data_in),
    .output_data(processed_data)
  );

  // Drive the output to avoid unused signal warnings for 'processed_data' and 'data_out'.
  assign data_out = processed_data;

endmodule
