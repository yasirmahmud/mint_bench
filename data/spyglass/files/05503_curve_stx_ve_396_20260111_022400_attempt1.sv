module curve_stx_ve_396_20260111_022400_attempt1 ();
  event my_event;

  // STX_VE_396: Invalid reference to event (my_event)
  // Using 'posedge' or 'negedge' with an 'event' variable is illegal in Verilog.
  // 'event' variables should be used with '@(my_event)' to wait for a trigger.
  always @(posedge my_event) begin
    // Empty block is sufficient to trigger the rule.
  end

endmodule
