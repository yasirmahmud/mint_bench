module sky130_fd_sc_hd__or2 (
    X   ,
    A   ,
    B   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output X;
    input  A;
    input  B;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // SpyGlass W240 Fix: Inputs VPWR, VGND, VPB, VNB are for physical connectivity
    // and power integrity, not directly used in the functional logic of this
    // behavioral model. Assigning to dummy wires to suppress "input declared
    // but not read" warnings. These dummy wires are intentionally left unused.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

    assign X = A | B;

endmodule
