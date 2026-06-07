module curve_synth_5288_20260110_180940_attempt8 ();

  // Declare an event variable, triggering SYNTH_5288 when used in always @
  event unique_trigger_event;

  // This always block is sensitive to the 'unique_trigger_event'
  // Usage of 'event' in a sensitivity list is not synthesizable and triggers SYNTH_5288.
  always @(unique_trigger_event) begin
    $display("SYNTH_5288: Event 'unique_trigger_event' detected.");
  end

endmodule
