module curve_stx_ve_396_20260111_022400_attempt3 ();
  event custom_event;
  reg data_status;

  // STX_VE_396: Invalid reference to event (custom_event)
  // Using 'posedge' or 'negedge' with an 'event' variable is illegal in Verilog.
  // 'event' variables should be used with '@(custom_event)' to wait for a trigger.
  always @(custom_event) begin
    data_status <= 1'b0;
  end

endmodule
