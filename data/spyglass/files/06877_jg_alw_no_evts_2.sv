module no_event_trigger_example_2 (
  input wire data_in,
  output reg data_out
);

  // This always block also lacks an event trigger, causing ALW_NO_EVTS
  always begin
    #5; // A delay does not constitute an event trigger
    data_out = data_in;
  end

endmodule
