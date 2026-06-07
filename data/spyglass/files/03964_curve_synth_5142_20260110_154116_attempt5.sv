module curve_synth_5142_20260110_154116_attempt5 (
  input wire i_clk,
  input wire i_reset,
  output reg o_data
);

  // Synthesizable logic to avoid unused signal warnings and make the module functional.
  // This ensures there are no unintended violations from basic design quality checks.
  always @(posedge i_clk or posedge i_reset) begin
    if (i_reset) begin
      o_data <= 1'b0;
    end else begin
      o_data <= ~o_data; // Simple toggling logic
    end
  end

  // First specify block: Contains a basic path delay statement.
  // Path delays are used purely for timing simulation and are ignored by synthesis tools.
  // This structure is expected to trigger one occurrence of the SYNTH_5142 rule.
  specify
    (i_clk => o_data) = (1:2:3); // Min:Typ:Max delay
  endspecify

  // Second specify block: Contains a specparam declaration within the specify block.
  // specparam within a specify block defines parameters for timing checks and delays,
  // which are also ignored by synthesis. This is distinct from a general 'parameter'.
  // This structure is expected to trigger a second occurrence of the SYNTH_5142 rule.
  specify
    specparam my_timing_constant = 10ps;
  endspecify

endmodule
