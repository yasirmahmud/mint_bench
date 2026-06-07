module sky130_fd_sc_hd__nor2b (
    Y   ,
    A   ,
    B_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output Y   ;
    input  A   ;
    input  B_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire not0_out         ;
    wire and0_out_Y       ;
    wire pwrgood_pp0_out_Y;

    //                                 Name         Output             Other arguments
    not                                not0        (not0_out         , A                     );
    and                                and0        (and0_out_Y       , not0_out, B_N         );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_Y, and0_out_Y, VPWR, VGND);
    buf                                buf0        (Y                , pwrgood_pp0_out_Y     );

endmodule
