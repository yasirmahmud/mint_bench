// Stub definition for sky130_fd_sc_hd__nor3b to resolve ErrorAnalyzeBBox linting violation.
// In a full design flow, this module would be provided by a standard cell library.
// The linting tool requires a definition for instantiated modules in the current compilation scope.
module sky130_fd_sc_hd__nor3b (
    output Y,
    input A,
    input B,
    input C_N,
    input VPWR,
    input VGND,
    input VPB,
    input VNB
);
    // No internal logic is added here. This stub merely declares the module interface
    // to satisfy the linter. The functional behavior of this base cell (Y = ~ (A | B | C_N))
    // is assumed to be defined in a separate library or source for synthesis/simulation.
endmodule
