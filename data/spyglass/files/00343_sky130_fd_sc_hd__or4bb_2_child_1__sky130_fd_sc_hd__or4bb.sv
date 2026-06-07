// Definition for the child module sky130_fd_sc_hd__or4bb
// This module implements the core OR logic with inverted C_N and D_N inputs.
module sky130_fd_sc_hd__or4bb (
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

    // Functional behavior: logical OR of A, B, and the inverted C_N and D_N to output X
    assign X = A | B | (~C_N) | (~D_N);

endmodule
