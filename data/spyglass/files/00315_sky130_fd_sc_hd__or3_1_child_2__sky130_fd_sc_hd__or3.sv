module sky130_fd_sc_hd__or3 (
    X,
    A,
    B,
    C,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output X;
    input  A;
    input  B;
    input  C;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    assign X = A | B | C;

    // Fix for W240: Inputs VPWR, VGND, VPB, VNB declared but not read.
    // These dummy assignments consume the power inputs to resolve linting warnings
    // without affecting the functional logic of the OR gate.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
