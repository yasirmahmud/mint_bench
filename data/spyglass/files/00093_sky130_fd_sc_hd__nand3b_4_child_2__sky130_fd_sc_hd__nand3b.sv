module sky130_fd_sc_hd__nand3b (
    Y,
    A_N,
    B,
    C,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A_N;
    input  B;
    input  C;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Implement the functional behavior of a 3-input NAND gate with input A_N (inverted A)
    assign Y = ~(A_N & B & C);

    // Dummy assignments to consume power/bias inputs and resolve W240 linting warnings.
    // These wires will be optimized away by synthesis tools and do not affect functional behavior.
    wire _sg_lint_fix_unused_VPWR = VPWR;
    wire _sg_lint_fix_unused_VGND = VGND;
    wire _sg_lint_fix_unused_VPB = VPB;
    wire _sg_lint_fix_unused_VNB = VNB;

endmodule
