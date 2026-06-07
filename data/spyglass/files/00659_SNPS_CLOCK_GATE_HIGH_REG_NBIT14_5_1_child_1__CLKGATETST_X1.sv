module CLKGATETST_X1 (
	input CK,
	input E,
	input SE,
	output GCK
);
    // Blackbox definition for SpyGlass to resolve "ErrorAnalyzeBBox".
    // The actual functional behavior of this clock gate cell is assumed to be
    // defined in a technology-specific library for synthesis and simulation.
    // For linting, providing the module interface is sufficient to resolve the undefined module error.
endmodule
