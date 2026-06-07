module constant_clock_assertion_1 (
  input clk // Declare clk as an input
);

  // The original localparam CLK_CONST = 1'b0; caused the PRP_NR_CSTC violation
  // because a property's clock must be a dynamic signal, not a constant.
  // By changing CLK_CONST to an input 'clk', the clock signal becomes dynamic.

  property p_always_true;
    @(posedge clk) (1); // Use the dynamic input clock 'clk'
  endproperty

  assert property (p_always_true); // Assertion statements are typically ignored by synthesis tools,
                                 // leading to SYNTH_5064 and SYNTH_12611 warnings for synthesis.
                                 // However, with a dynamic clock, the property itself is valid for simulation.

endmodule
