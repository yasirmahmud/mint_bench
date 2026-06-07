module UndrivenClockAssert1(
  input logic undriven_clk
);

  // The original PRP_NO_DRVC warning indicated that 'undriven_clk' was
  // not driven. By making 'undriven_clk' an input port, the module
  // expects the clock to be driven by its environment, resolving the
  // 'undriven' issue from the module's perspective for both synthesis
  // and formal verification/simulation.
  // The simulation-only clock driver (initial and always #5) has been
  // removed as it introduced several synthesis and linting violations
  // (SYNTH_5143, CombLoop, W122, W421, CheckDelayTimescale-ML).

  // The 'assert property' statement is not synthesizable, leading to SYNTH_5064.
  // To resolve this violation while preserving the assertion for simulation/formal
  // verification, it is conditionally compiled out during synthesis.
`ifndef SYNTHESIS
  assert property (@(posedge undriven_clk) 1'b1);
`endif

endmodule
