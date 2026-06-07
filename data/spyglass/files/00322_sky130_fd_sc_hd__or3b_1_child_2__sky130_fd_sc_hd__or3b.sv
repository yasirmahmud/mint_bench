module sky130_fd_sc_hd__or3b (
    X   ,
    A   ,
    B   ,
    C_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output X;
    input  A;
    input  B;
    input  C_N;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    assign X = A | B | (~C_N);

    // Dummy assignments to resolve W240 warnings for unused power/ground pins.
    // These assignments do not affect the functional logic of the OR gate.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
