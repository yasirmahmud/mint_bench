module SNPS_CLOCK_GATE_HIGH_REG_NBIT15_7_0  ( CLK, EN, ENCLK, TE );

  input CLK, EN, TE;
  output ENCLK;

  // Instantiate the defined clock gating cell. The 'TE' input maps to the 'SE' port.
  CLKGATETST_X1 latch ( .CK(CLK), .E(EN), .SE(TE), .GCK(ENCLK) );

endmodule
