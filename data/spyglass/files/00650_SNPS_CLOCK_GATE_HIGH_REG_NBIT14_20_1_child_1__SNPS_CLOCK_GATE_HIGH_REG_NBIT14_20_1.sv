// Original top module definition
module SNPS_CLOCK_GATE_HIGH_REG_NBIT14_20_1  (
	CLK, 
	EN, 
	ENCLK, 
	TE);

   input CLK;
   input EN;
   output ENCLK;
   input TE;

   // Instantiate the defined clock gating latch.
   // This resolves the 'ErrorAnalyzeBBox' violation by providing the definition
   // for 'CLKGATETST_X1'.
   CLKGATETST_X1 latch (.CK(CLK),
	.E(EN),
	.SE(TE),
	.GCK(ENCLK));
endmodule
