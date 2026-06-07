module SNPS_CLOCK_GATE_HIGH_REG_NBIT15_9_0  ( CLK, EN, ENCLK, TE );

  input CLK, EN, TE;
  output ENCLK;


  // Instance of the clock gate cell
  CLKGATETST_X1 latch ( .CK(CLK), .E(EN), .SE(TE), .GCK(ENCLK) );

endmodule
