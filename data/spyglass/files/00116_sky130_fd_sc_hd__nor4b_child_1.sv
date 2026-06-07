module sky130_fd_sc_hd__nor4b (
    Y   ,
    A   ,
    B   ,
    C_N ,
    D_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  C_N ;
    input  D_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Functional behavior: Four-input NOR gate with inputs A, B, C_N, D_N.
    // C_N and D_N are considered active-low inputs as per typical _N naming convention,
    // so they are directly used in the NOR function.
    assign Y = !(A | B | C_N | D_N);

endmodule
