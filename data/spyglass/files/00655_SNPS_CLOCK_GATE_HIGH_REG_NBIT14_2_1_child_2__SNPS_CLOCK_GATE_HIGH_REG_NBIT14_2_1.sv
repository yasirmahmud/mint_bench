// Original module SNPS_CLOCK_GATE_HIGH_REG_NBIT14_2_1
module SNPS_CLOCK_GATE_HIGH_REG_NBIT14_2_1  (
	CLK, 
	EN, 
	ENCLK, 
	TE);

   input CLK;
   input EN;
   output ENCLK;
   input TE;

   // The instantiation of CLKGATETST_X1 now has a defined module, resolving the ErrorAnalyzeBBox violation.
   CLKGATETST_X1 latch (.CK(CLK),
	.E(EN),
	.SE(TE),
	.GCK(ENCLK));
endmodule
