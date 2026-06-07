module curve_stx_ve_396_20260111_022400_attempt5 ();
  event data_ready_event;
  reg process_active;

  // STX_VE_396: Invalid reference to event (data_ready_event)
  // Verilog LRM states that 'posedge' and 'negedge' are not allowed with 'event' variables.
  // Events should be awaited using '@(event_name)' in an event control expression.
  always @(data_ready_event) begin // Fixed: Changed 'posedge data_ready_event' to 'data_ready_event'
    process_active <= 1'b1;
  end

endmodule
