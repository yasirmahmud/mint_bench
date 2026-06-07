module curve_stx_ve_396_20260111_022400_attempt4 ();
  event transaction_complete;
  reg is_done_flag;

  // STX_VE_396: Invalid reference to event (transaction_complete)
  // Using 'negedge' or 'posedge' with an 'event' variable is illegal in Verilog.
  // 'event' variables should be used with '@(event_name)' to wait for a trigger.
  always @(negedge transaction_complete) begin
    is_done_flag <= 1'b1;
  end

endmodule
