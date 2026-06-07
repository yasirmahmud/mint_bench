module curve_stx_ve_396_20260111_022400_attempt2 ();
  event trigger_event;
  reg output_status;

  // STX_VE_396: Invalid reference to event (trigger_event)
  // Using 'negedge' or 'posedge' with an 'event' variable is illegal in Verilog.
  // 'event' variables should be used with '@(trigger_event)' to wait for a trigger.
  always @(trigger_event) begin
    output_status <= 1'b1;
  end

endmodule
