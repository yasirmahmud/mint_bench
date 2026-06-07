module SNPS_CLOCK_GATE_HIGH_REG_NBIT15_28_0  ( CLK, EN, ENCLK, TE );

  input CLK, EN, TE;
  output ENCLK;

  // Instance of the clock gating cell, now with a defined module.
  CLKGATETST_X1 latch ( .CK(CLK), .E(EN), .SE(TE), .GCK(ENCLK) );
endmodule
