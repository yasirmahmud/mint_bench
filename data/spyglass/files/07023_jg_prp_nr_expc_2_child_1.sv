module complex_clock_prop_2 (
  input clk_main,
  input clk_aux,
  input reset,
  input valid
);

  // The original property used an OR-gated clock (clk_main || clk_aux),
  // which often triggers PRP_NR_EXPC and makes clock analysis difficult for linting tools.
  // To resolve this while preserving the functional intent (checking on either clock edge),
  // the property is split into two separate properties, each clocked by a single, explicit clock.

  property p_valid_on_reset_main;
    @(posedge clk_main) reset |-> !valid;
  endproperty

  assert property (p_valid_on_reset_main);

  property p_valid_on_reset_aux;
    @(posedge clk_aux) reset |-> !valid;
  endproperty

  assert property (p_valid_on_reset_aux);

endmodule
