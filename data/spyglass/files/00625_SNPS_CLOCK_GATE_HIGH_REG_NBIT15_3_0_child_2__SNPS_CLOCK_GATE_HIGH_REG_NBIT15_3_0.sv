module SNPS_CLOCK_GATE_HIGH_REG_NBIT15_3_0  ( CLK, EN, ENCLK, TE );

  input CLK, EN, TE;
  output ENCLK;

  // Instantiate the defined clock gate latch module
  CLKGATETST_X1 latch ( .CK(CLK), .E(EN), .SE(TE), .GCK(ENCLK) );

endmodule
