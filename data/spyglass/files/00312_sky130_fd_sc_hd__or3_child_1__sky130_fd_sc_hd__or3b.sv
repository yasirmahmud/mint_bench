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

    output X   ;
    input  A   ;
    input  B   ;
    input  C_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Implements X = A | B | (~C_N) based on the description:
    // "passing signals A, B, and the inverted C_N through an instantiated base module"
    assign X = A | B | (~C_N);

endmodule
