module curve_synth_5142_20260110_154116_attempt3 (
  input wire clk,
  input wire data_in,
  output wire data_out
);

  // Notifier registers used by the specify blocks
  reg notifier_reg_1;
  reg notifier_reg_2;

  // Simple combinational assignment to prevent unused signal warnings for inputs/outputs
  assign data_out = data_in;

  // First specify block, which will be ignored for synthesis, triggering SYNTH_5142
  specify
    $setup(data_in, posedge clk, 10, notifier_reg_1);
  endspecify

  // Second specify block, also triggering SYNTH_5142, resulting in two occurrences
  specify
    $setup(data_in, posedge clk, 12, notifier_reg_2);
  endspecify

endmodule
