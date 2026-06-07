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

    // Dummy assignments to consume power/ground inputs and resolve W240 violations.
    // These assignments read the inputs but do not affect the functional output Y.
    // Synthesis tools will typically optimize these unused wires away.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

    // Implement a four-input NOR gate with an inverted D_N input.
    // The D_N input itself is treated as one of the four inputs to the NOR gate.
    assign Y = ~(A | B | C | D_N);

endmodule
