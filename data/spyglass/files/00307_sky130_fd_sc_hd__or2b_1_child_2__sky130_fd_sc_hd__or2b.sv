module sky130_fd_sc_hd__or2b (
    X,
    A,
    B_N,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output X;
    input A;
    input B_N;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    // Fix for SpyGlass W240: Inputs declared but not read.
    // These inputs (VPWR, VGND, VPB, VNB) are essential for power, ground, and bulk connections
    // in standard cell definitions and must remain in the port list to preserve the design's
    // intended interface, as per the natural language description. Dummy assignments are used
    // to explicitly "read" these inputs without affecting the functional logic of the OR gate.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

    assign X = A | (~B_N);

endmodule // sky130_fd_sc_hd__or2b
