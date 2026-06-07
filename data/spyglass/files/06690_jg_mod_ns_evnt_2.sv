module event_wait_violation();
  reg data_out;
  event data_ready_event;

  initial begin
    data_out = 1'b0;
    #5 -> data_ready_event; // Trigger the event
  end

  always @data_ready_event begin // Waiting for a named event
    data_out = ~data_out;
  end
endmodule
