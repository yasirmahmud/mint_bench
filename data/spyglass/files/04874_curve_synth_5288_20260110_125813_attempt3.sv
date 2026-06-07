module curve_synth_5288_20260110_125813_attempt3 ();

  // Declare an event type variable.
  event my_event;

  // This 'always' block is sensitive to an 'event' variable.
  // This is the direct cause of the SYNTH_5288 violation (Usage of 'event' is not synthesizable).
  // The $display statement is a non-synthesizable construct and helps to avoid other unintended synthesis rule violations
  // (like W122 from the previous attempt) by not involving any synthesizable logic within this block.
  always @(my_event) begin
    $display("SYNTH_5288: Event 'my_event' triggered.");
  end

endmodule
