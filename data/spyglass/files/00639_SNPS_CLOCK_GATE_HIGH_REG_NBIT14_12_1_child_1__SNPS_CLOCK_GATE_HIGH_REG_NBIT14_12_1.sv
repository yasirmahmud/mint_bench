module SNPS_CLOCK_GATE_HIGH_REG_NBIT14_12_1  (
	CLK, 
	EN, 
	ENCLK, 
	TE);

   input CLK;
   input EN;
   output ENCLK;
   input TE;

   // Instantiate the defined clock gating cell.
   // This resolves the 'ErrorAnalyzeBBox' violation by providing the definition
   // for CLKGATETST_X1, which was previously treated as an undefined black box.
   CLKGATETST_X1 latch (.CK(CLK),
	.E(EN),
	.SE(TE),
	.GCK(ENCLK));

endmodule
