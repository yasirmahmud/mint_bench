module curve_stx_ve_396_20260111_184323_023959_w53504_attempt8();

  event my_signal_event;
  reg output_status;

  // STX_VE_396 violation: Invalid reference to event 'my_signal_event' in a negedge sensitivity list
  // FIX: Events cannot have edge specifiers. An 'always @(event)' block triggers when the event is fired.
  always @(my_signal_event) begin
    output_status <= 1'b0;
  end

endmodule
