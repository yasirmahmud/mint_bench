module example_nevt_posedge(
  input my_trigger_i // Synthesizable replacement for event trigger
);

  // The original 'event my_event_pos;' declaration and the 'initial' block
  // containing '#10 -> my_event_pos;' have been removed because 'event'
  // and 'initial' blocks with time delays are not synthesizable.
  //
  // To preserve the functional behavior of a trigger that the 'always' block
  // responds to, 'my_event_pos' is replaced with a synthesizable input 'my_trigger_i'.
  // In synthesizable logic, an event trigger is often best represented by the
  // positive edge of a control signal.

  always @(posedge my_trigger_i) begin
    $display("my_event_pos triggered!");
  end
endmodule
