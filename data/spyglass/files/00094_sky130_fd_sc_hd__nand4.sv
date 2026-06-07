module sky130_fd_sc_hd__nand4b (
    Y   ,
    A_N ,
    B   ,
    C   ,
    D   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output Y   ;
    input  A_N ;
    input  B   ;
    input  C   ;
    input  D   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire not0_out         ;
    wire nand0_out_Y      ;
    wire pwrgood_pp0_out_Y;

    //                                 Name         Output             Other arguments
    not                                not0        (not0_out         , A_N                    );
    nand                               nand0       (nand0_out_Y      , D, C, B, not0_out      );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_Y, nand0_out_Y, VPWR, VGND);
    buf                                buf0        (Y                , pwrgood_pp0_out_Y      );

endmodule
