module curve_synth_5142_20260110_154116_attempt4 (
  input wire clk,
  input wire data_in,
  output reg data_out
);

  // Use clk and data_in in synthesizable logic to avoid 'unused signal' warnings (e.g., W240).
  // This creates a simple D-flip-flop, making the module otherwise synthesizable.
  always @(posedge clk) begin
    data_out <= data_in;
  end

  // Notifier registers are single-bit by default and used exclusively by specify blocks.
  reg notifier_reg_1;
  reg notifier_reg_2;

  // First specify block: This structure with a $setup timing check is universally ignored by synthesis tools.
  // It is expected to trigger one occurrence of the SYNTH_5142 rule.
  specify
    $setup(data_in, posedge clk, 10, notifier_reg_1);
  endspecify

  // Second specify block: A separate specify block to achieve the target of 2 total occurrences
  // for the SYNTH_5142 rule.
  specify
    $setup(data_in, posedge clk, 12, notifier_reg_2);
  endspecify

endmodule
