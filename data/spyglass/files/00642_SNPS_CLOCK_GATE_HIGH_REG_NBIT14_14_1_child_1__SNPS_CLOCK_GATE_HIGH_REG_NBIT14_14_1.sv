module SNPS_CLOCK_GATE_HIGH_REG_NBIT14_14_1  (
	CLK,
	EN,
	ENCLK,
	TE);

   input CLK;
   input EN;
   output ENCLK;
   input TE;

   // Instantiate the clock gate cell. By defining CLKGATETST_X1, the black-box violation is resolved.
   CLKGATETST_X1 latch (.CK(CLK),
	.E(EN),
	.SE(TE),
	.GCK(ENCLK));
endmodule
