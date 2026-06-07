module SNPS_CLOCK_GATE_HIGH_REG_NBIT14_15_1  (
	CLK, 
	EN, 
	ENCLK, 
	TE);

   input CLK;
   input EN;
   output ENCLK;
   input TE;

   // Instantiate the behavioral model for the clock gate cell
   CLKGATETST_X1 latch (.CK(CLK),
	.E(EN),
	.SE(TE),
	.GCK(ENCLK));

endmodule
