module curve_synth_12610_20260111_174258_710501_w37940_attempt10 (
  input wire clk,
  input wire rst_n,
  input wire trigger_start,
  input wire trigger_end,
  output wire dummy_output
);

  // SYNTH_12610: Sequence blocks will be ignored for synthesis due to large delay range.
  // The delay range [1:3000] is deliberately large to trigger this warning.
  sequence synth_ignore_sequence_10;
    @(posedge clk) trigger_start ##[1:3000] trigger_end;
  endsequence

  // Assign a dummy output using all inputs to prevent unused signal warnings (e.g., W240).
  // The usage within a 'sequence' does not always prevent unused signal warnings in synthesis/linting.
  assign dummy_output = clk ^ rst_n ^ trigger_start ^ trigger_end;

endmodule
