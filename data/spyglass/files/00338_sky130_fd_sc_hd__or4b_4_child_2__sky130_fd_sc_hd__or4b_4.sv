module sky130_fd_sc_hd__or4b_4 (
    X   ,
    A   ,
    B   ,
    C   ,
    D_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  D_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    
    // Instantiate the base cell, which is now defined in this file
    sky130_fd_sc_hd__or4b base (
        .X(X),
        .A(A),
        .B(B),
        .C(C),
        .D_N(D_N),
        .VPWR(VPWR),
        .VGND(VGND),
        .VPB(VPB),
        .VNB(VNB)
    );

endmodule
