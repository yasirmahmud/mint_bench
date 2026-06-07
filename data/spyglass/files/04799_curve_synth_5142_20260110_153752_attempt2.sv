module curve_synth_5142_20260110_153752_attempt2 (
  input wire clk,
  input wire data_in,
  output wire data_out
);

  reg q_reg;
  reg notifier_reg;

  // Synthesizable logic to use inputs/outputs and avoid other lint warnings
  always @(posedge clk) begin
    q_reg <= data_in;
  end

  assign data_out = q_reg;

  // The 'specify' block containing a system timing check like $setup is non-synthesizable.
  // This block (or its content) will be ignored by synthesis tools, triggering SYNTH_5142.
  specify
    $setup(data_in, posedge clk, 10, notifier_reg);
  endspecify

endmodule
