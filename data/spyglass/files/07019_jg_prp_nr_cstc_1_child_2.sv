module constant_clock_assertion_1 (
  input clk // Declare clk as an input
);

  // To resolve W240 (Input 'clk' declared but not read), we add a synthesizable dummy usage.
  // Since 'clk' is primarily used as the clock for a simulation-only assertion,
  // synthesis tools might otherwise flag it as unused. This dummy assignment
  // ensures 'clk' is considered 'read' without altering functional behavior,
  // as this wire will be optimized away if not used to drive other logic.
  wire unused_clk_sink;
  assign unused_clk_sink = clk;

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
