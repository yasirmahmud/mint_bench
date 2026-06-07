// Dummy definition for the base cell to resolve the ErrorAnalyzeBBox violation.
// This provides the linter with the module's interface, allowing it to verify connections,
// without altering the functional behavior which relies on the actual library definition
// of sky130_fd_sc_hd__sdfrbp in synthesis and simulation.
module sky130_fd_sc_hd__sdfrbp (
    Q,
    Q_N,
    CLK,
    D,
    SCD,
    SCE,
    RESET_B,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Q;
    output Q_N;
    input CLK;
    input D;
    input SCD;
    input SCE;
    input RESET_B;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;
endmodule
