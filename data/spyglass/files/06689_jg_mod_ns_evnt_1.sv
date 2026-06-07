module event_trigger_violation();
  event my_event;

  initial begin
    #10 -> my_event; // Triggering a named event
  end
endmodule
