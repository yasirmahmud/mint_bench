module sky130_fd_sc_hd__dlymetal6s4s (
    X   ,
    A   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output X   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire buf0_out_X       ;
    wire pwrgood_pp0_out_X;

    //                                 Name         Output             Other arguments
    buf                                buf0        (buf0_out_X       , A                     );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_X, buf0_out_X, VPWR, VGND);
    buf                                buf1        (X                , pwrgood_pp0_out_X     );

endmodule
