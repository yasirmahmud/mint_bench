module UndrivenClockAssert1();
  logic undriven_clk;

  // Add a simple clock driver for undriven_clk to resolve the 'undriven' issue
  // mentioned in the design description (PRP_NO_DRVC).
  initial undriven_clk = 1'b0;
  always #5 undriven_clk = ~undriven_clk;

  // The 'assert property' statement is not synthesizable, leading to SYNTH_5064.
  // To resolve this violation while preserving the assertion for simulation/formal
  // verification, it is conditionally compiled out during synthesis.
`ifndef SYNTHESIS
  assert property (@(posedge undriven_clk) 1'b1);
`endif

endmodule
