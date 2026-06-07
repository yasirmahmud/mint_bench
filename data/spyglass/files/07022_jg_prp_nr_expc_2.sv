module complex_clock_prop_2 (
  input clk_main,
  input clk_aux,
  input reset,
  input valid
);

  property p_valid_on_reset;
    @(posedge (clk_main || clk_aux)) reset |-> !valid;
  endproperty

  assert property (p_valid_on_reset);

endmodule
