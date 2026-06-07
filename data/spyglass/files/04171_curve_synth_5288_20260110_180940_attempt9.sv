module curve_synth_5288_20260110_180940_attempt9 (
  input wire some_input,
  output reg some_output
);

  // Declare an event variable.
  event my_unique_event;

  // This always block is sensitive to the 'my_unique_event'.
  // Usage of 'event' in a sensitivity list is explicitly unsynthesizable
  // and triggers the SYNTH_5288 violation.
  always @(my_unique_event) begin
    // This internal logic is synthesizable, but the sensitivity list is not.
    // Replacing `$display` from previous attempts with an assignment
    // to avoid triggering `ErrorAnalyzeBBox` for unsynthesizable content.
    some_output = some_input;
  end

  // No logic to trigger the event itself, as the violation occurs solely
  // from its usage in the 'always @' sensitivity list.

endmodule
