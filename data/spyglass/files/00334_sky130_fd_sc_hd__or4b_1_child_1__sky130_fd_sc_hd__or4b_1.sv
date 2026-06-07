module sky130_fd_sc_hd__or4b_1 (
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
    
    sky130_fd_sc_hd__or4b base (
        .X(X),
        .A(A),
        .B(B),
        .C(C),
        .D_N(D_N), // The D_N input from the wrapper is passed to the base cell.
                   // The base cell then applies the inversion as defined above.
        .VPWR(VPWR),
        .VGND(VGND),
        .VPB(VPB),
        .VNB(VNB)
    );

endmodule
