module sky130_fd_sc_hd__o21ba (
    X   ,
    A1  ,
    A2  ,
    B1_N,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output X   ;
    input  A1  ;
    input  A2  ;
    input  B1_N;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire nor0_out         ;
    wire nor1_out_X       ;
    wire pwrgood_pp0_out_X;

    //                                 Name         Output             Other arguments
    nor                                nor0        (nor0_out         , A1, A2                );
    nor                                nor1        (nor1_out_X       , B1_N, nor0_out        );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_X, nor1_out_X, VPWR, VGND);
    buf                                buf0        (X                , pwrgood_pp0_out_X     );

endmodule
