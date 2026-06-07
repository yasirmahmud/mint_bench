module sky130_fd_sc_hd__or4b (
    X   ,
    A   ,
    B   ,
    C_N ,
    D_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B   ;
    input  C_N ;
    input  D_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // This defines the functional behavior of the OR gate element.
    // X is the logical OR of A, B, and the logical inversions of C_N and D_N.
    // Given C_N and D_N are typically active-low inputs in OR4B gates,
    // they contribute to an active-high output when they are low (i.e., their inverted value is high).
    assign X = A | B | (~C_N) | (~D_N);

endmodule
