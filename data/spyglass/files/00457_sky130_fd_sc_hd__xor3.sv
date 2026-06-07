module sky130_fd_sc_hd__xor3 (
    X   ,
    A   ,
    B   ,
    C   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output X   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire xor0_out_X       ;
    wire pwrgood_pp0_out_X;

    //                                 Name         Output             Other arguments
    xor                                xor0        (xor0_out_X       , A, B, C               );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_X, xor0_out_X, VPWR, VGND);
    buf                                buf0        (X                , pwrgood_pp0_out_X     );

endmodule
