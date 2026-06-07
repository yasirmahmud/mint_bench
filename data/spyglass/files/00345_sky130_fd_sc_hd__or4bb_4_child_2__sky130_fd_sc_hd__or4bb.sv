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

    assign X = A | B | (~C_N) | (~D_N);

    // Dummy assignments to resolve W240 SpyGlass violations for unused power/ground inputs.
    // These inputs are for power connectivity and do not participate in logic calculation directly.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
