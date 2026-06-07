module sky130_fd_sc_hd__nor4b (
    Y   ,
    A   ,
    B   ,
    C   ,
    D_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output Y   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  D_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Implement a four-input NOR gate with an inverted D_N input.
    // The D_N input itself is treated as one of the four inputs to the NOR gate.
    assign Y = ~(A | B | C | D_N);

endmodule
