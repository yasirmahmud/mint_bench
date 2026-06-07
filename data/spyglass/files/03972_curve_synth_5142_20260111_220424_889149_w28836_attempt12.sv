module curve_synth_5142_20260111_220424_889149_w28836_attempt12 (
  input wire clk,
  input wire data_in,
  output reg data_out
);

  // Simple flop to connect input to output, preventing unused signal warnings
  always @(posedge clk) begin
    data_out <= data_in;
  end

  // This first specify block contains a specparam, which is purely for simulation
  // and is ignored by synthesis tools. This triggers the first SYNTH_5142 violation.
  specify
    specparam CLK_DELAY = 5.0; // A specify parameter, typically used for simulation delays.
  endspecify

  // This second specify block contains a $width timing check. Timing checks
  // are simulation-specific and are ignored by synthesis, triggering the second SYNTH_5142 violation.
  // The $width check here is simplified to avoid any potential unused signal warnings for a 'notifier'.
  specify
    // $width(reference_event, limit, threshold)
    $width(posedge clk, 10, 5);
  endspecify

endmodule
