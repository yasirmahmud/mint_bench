module sky130_fd_sc_hd__and4bb (
    X   ,
    A_N ,
    B_N ,
    C   ,
    D   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output X   ;
    input  A_N ;
    input  B_N ;
    input  C   ;
    input  D   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire nor0_out         ;
    wire and0_out_X       ;
    wire pwrgood_pp0_out_X;

    //                                 Name         Output             Other arguments
    nor                                nor0        (nor0_out         , A_N, B_N              );
    and                                and0        (and0_out_X       , nor0_out, C, D        );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_X, and0_out_X, VPWR, VGND);
    buf                                buf0        (X                , pwrgood_pp0_out_X     );

endmodule
