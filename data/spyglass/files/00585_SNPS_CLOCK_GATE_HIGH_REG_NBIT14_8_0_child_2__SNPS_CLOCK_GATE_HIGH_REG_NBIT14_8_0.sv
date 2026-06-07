module SNPS_CLOCK_GATE_HIGH_REG_NBIT14_8_0  ( CLK, EN, ENCLK, TE );

  input CLK, EN, TE;
  output ENCLK;

  // Instance of the clock gate cell, now with a defined behavior.
  CLKGATETST_X1 latch ( .CK(CLK), .E(EN), .SE(TE), .GCK(ENCLK) );

endmodule
