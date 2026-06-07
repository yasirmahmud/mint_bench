module curve_synth_5288_20260110_125813_attempt4 (
  input wire i_data,
  output wire o_data
);

  // Declare an event type variable.
  event my_event;

  // This 'always' block is sensitive to an 'event' variable.
  // This construct is explicitly non-synthesizable and triggers the SYNTH_5288 violation.
  always @(my_event) begin
    // The $display statement is non-synthesizable but is contained within
    // an already non-synthesizable block, minimizing extraneous rule triggers.
    $display("SYNTH_5288: Event 'my_event' triggered.");
  end

  // Add a minimal synthesizable path to ensure the tool doesn't flag
  // the entire design unit as unsynthesizable (e.g., ErrorAnalyzeBBox) due
  // to the presence of only non-synthesizable constructs. This 'assign' statement
  // is synthesizable and uses all declared inputs/outputs.
  assign o_data = i_data;

endmodule
