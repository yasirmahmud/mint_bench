module curve_synth_5405_20260111_223847_659004_w28836_attempt11 (
  input  [1:0] system_clk_bus,
  input        data_in,
  output reg   data_out
);

  // SYNTH_5405 violation: Clock expression 'system_clk_bus' must be one bit wide.
  // This rule is triggered because the 'system_clk_bus' signal, which is 2 bits wide,
  // is used directly as the clock in an 'always @(posedge ...)' sensitivity list.
  always @(posedge system_clk_bus) begin
    data_out <= data_in;
  end

endmodule
