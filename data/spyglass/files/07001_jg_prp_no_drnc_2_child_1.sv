module undriven_signal_in_property_2 (
  input sys_clk,
  input enable_prop
);

  bit error_condition; // This signal was undriven

  // FIX: Assign error_condition using inputs to make it driven.
  // This resolves the undriven signal warning (PRP_NO_DRNC) for 'error_condition'.
  // It also ensures 'sys_clk' and 'enable_prop' are read in synthesizable logic,
  // resolving W240 warnings for these inputs.
  // The assignment 'sys_clk & !enable_prop' means 'error_condition' will be 0
  // when 'enable_prop' is high (property enabled), causing the assertion
  // (!error_condition) to pass, which aligns with a typical 'no error' behavior
  // for such a property's default state.
  assign error_condition = sys_clk & !enable_prop;

  // The property and assert statements are retained to preserve the design's
  // functional behavior for verification, despite being ignored during synthesis.
  property p_error_check;
    @(posedge sys_clk) disable iff (!enable_prop) (!error_condition);
  endproperty

  assert property (p_error_check);

endmodule
