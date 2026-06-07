module SNPS_CLOCK_GATE_HIGH_REG_NBIT14_3_1  (
	CLK, 
	EN, 
	ENCLK, 
	TE);

   input CLK;
   input EN;
   output ENCLK;
   input TE;

   // Instantiation of the defined clock gating cell
   CLKGATETST_X1 latch (.CK(CLK),
	.E(EN),
	.SE(TE),
	.GCK(ENCLK));
endmodule
