module sky130_fd_sc_hd__nor3b (
    Y   ,
    A   ,
    B   ,
    C_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output Y   ;
    input  A   ;
    input  B   ;
    input  C_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire nor0_out         ;
    wire and0_out_Y       ;
    wire pwrgood_pp0_out_Y;

    //                                 Name         Output             Other arguments
    nor                                nor0        (nor0_out         , A, B                  );
    and                                and0        (and0_out_Y       , C_N, nor0_out         );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_Y, and0_out_Y, VPWR, VGND);
    buf                                buf0        (Y                , pwrgood_pp0_out_Y     );

endmodule
