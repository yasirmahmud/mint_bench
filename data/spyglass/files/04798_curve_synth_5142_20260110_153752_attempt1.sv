module curve_synth_5142_20260110_153752_attempt1 (
  input wire clk,
  input wire data_in,
  output wire data_out
);

  // A notifier register is typically used with timing checks like $setup.
  reg notifier_reg;

  // Simple logic to ensure inputs/outputs are used and avoid other lint violations.
  assign data_out = data_in;

  // The 'specify' block is ignored for synthesis, triggering SYNTH_5142.
  specify
    // A system timing check like $setup is non-synthesizable and resides in a specify block.
    $setup(data_in, posedge clk, 10, notifier_reg);
  endspecify

endmodule
