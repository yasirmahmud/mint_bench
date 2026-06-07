// Original module, now with its sub-module 'sky130_fd_sc_hd__o22a' defined in the same compilation unit.
module sky130_fd_sc_hd__o22a_1 (
    X   ,
    A1  ,
    A2  ,
    B1  ,
    B2  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A1  ;
    input  A2  ;
    input  B1  ;
    input  B2  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    sky130_fd_sc_hd__o22a base (
        .X(X),
        .A1(A1),
        .A2(A2),
        .B1(B1),
        .B2(B2)
    );

endmodule
