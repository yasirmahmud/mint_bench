module undriven_signal_in_property_2 (
  input sys_clk,
  input enable_prop
);

  bit error_condition; // This signal will be undriven

  property p_error_check;
    @(posedge sys_clk) disable iff (!enable_prop) (!error_condition);
  endproperty

  assert property (p_error_check);

endmodule
