module SNPS_CLOCK_GATE_HIGH_REG_NBIT14_23_0  (
  input CLK,
  input EN,
  output ENCLK,
  input TE
);


  // Instantiate the defined clock gate cell
  CLKGATETST_X1 latch ( .CK(CLK), .E(EN), .SE(TE), .GCK(ENCLK) );

endmodule
