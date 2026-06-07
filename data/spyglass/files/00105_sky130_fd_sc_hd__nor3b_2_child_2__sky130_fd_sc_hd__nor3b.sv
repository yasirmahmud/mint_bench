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
    input  VPWR; // spyglass disable_rule W240
    input  VGND; // spyglass disable_rule W240
    input  VPB ; // spyglass disable_rule W240
    input  VNB ; // spyglass disable_rule W240

    // Functional behavior: Y is the NOR of A, B, and C_N
    assign Y = ~(A | B | C_N);

endmodule
