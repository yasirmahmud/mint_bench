module curve_synth_126_20260111_022821_attempt4 (
  input  [7:0] data_in,
  output [7:0] data_out
);

  wire [7:0] internal_signal;

  // SYNTH_126: Procedural continuous assign statements are not synthesizable
  // Placing an 'assign' statement inside a procedural 'initial' block
  // makes it a procedural continuous assign, which is not synthesizable.
  initial begin
    assign internal_signal = data_in; // This line triggers SYNTH_126
  end

  // A standard continuous assign to connect the internal signal to the output.
  // This part is synthesizable and ensures 'data_out' is driven.
  assign data_out = internal_signal;

endmodule
