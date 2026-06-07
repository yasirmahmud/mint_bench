// Definition of the base XOR2 module to resolve the black-box violation
module sky130_fd_sc_hd__xor2 (
    X,
    A,
    B,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output X;
    input A;
    input B;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    assign X = A ^ B;

    // Dummy usage to prevent W240 warnings for power/ground/well inputs
    // These signals are physically connected but not logically "read" in the main logic.
    // The following line serves only to silence the linting tool.
    wire _unused_pg_signals = VPWR | VGND | VPB | VNB;

endmodule
