module no_event_trigger_example_1 (
  output reg my_output
);

  // This always block has no event trigger, directly violating ALW_NO_EVTS
  always begin
    my_output = ~my_output; // Toggles the output continuously
  end

endmodule
