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

    // Implements X = A | B | (~C_N)
    assign X = A | B | (~C_N);

    // Resolve W240 for unused power/ground inputs.
    // These ports are for physical connection and do not affect logical behavior.
    // Dummy assignments are used to prevent lint warnings for 'declared but not read' inputs.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB = VPB;
    wire _unused_VNB = VNB;

endmodule
