module SNPS_CLOCK_GATE_HIGH_REG_NBIT14_9_1  (
	CLK, 
	EN, 
	ENCLK, 
	TE);

   input CLK;
   input EN;
   output ENCLK;
   input TE;

   // Instantiate the clock gating cell, which is now defined above.
   CLKGATETST_X1 latch (.CLK(CLK),
	.E(EN),
	.SE(TE),
	.GCK(ENCLK));

endmodule
