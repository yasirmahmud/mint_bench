module sky130_fd_sc_hd__o211ai_4_child_2 (
    Y,
    A1,
    A2,
    B1,
    C1,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A1;
    input  A2;
    input  B1;
    input  C1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // This module instantiates an underlying o211ai cell that processes inputs A1, A2, B1, and C1 alongside power and ground signals to produce the output Y.
    sky130_fd_sc_hd__o211ai u_o211ai (
        .Y(Y),
        .A1(A1),
        .A2(A2),
        .B1(B1),
        .C1(C1),
        .VPWR(VPWR),
        .VGND(VGND),
        .VPB(VPB),
        .VNB(VNB)
    );

endmodule
