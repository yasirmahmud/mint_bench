module SNPS_CLOCK_GATE_HIGH_REG_NBIT15_15_0  ( CLK, EN, ENCLK, TE );

  input CLK, EN, TE;
  output ENCLK;


  // Instantiate the defined clock gate cell.
  // .CK (Clock) -> CLK
  // .E  (Enable) -> EN
  // .SE (Scan Enable/Test Enable) -> TE
  // .GCK (Gated Clock) -> ENCLK
  CLKGATETST_X1 latch ( .CK(CLK), .E(EN), .SE(TE), .GCK(ENCLK) );
endmodule
