module sky130_fd_sc_hd__nor3b (
    Y   ,
    A   ,
    B   ,
    C_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  C_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Functional behavior: Y is the NOR of A, B, and C_N
    assign Y = ~(A | B | C_N);

endmodule
