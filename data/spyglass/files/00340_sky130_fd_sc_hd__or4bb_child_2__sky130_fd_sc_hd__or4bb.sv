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

    // To resolve SpyGlass 'input declared but not read' warnings for power/ground pins,
    // dummy assignments are added. These do not affect functional behavior and are
    // typically optimized away by synthesis tools.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
