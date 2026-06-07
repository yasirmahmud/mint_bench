module sky130_fd_sc_hd__a41o (
    X   ,
    A1  ,
    A2  ,
    A3  ,
    A4  ,
    B1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output X   ;
    input  A1  ;
    input  A2  ;
    input  A3  ;
    input  A4  ;
    input  B1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire and0_out         ;
    wire or0_out_X        ;
    wire pwrgood_pp0_out_X;

    //                                 Name         Output             Other arguments
    and                                and0        (and0_out         , A1, A2, A3, A4       );
    or                                 or0         (or0_out_X        , and0_out, B1         );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_X, or0_out_X, VPWR, VGND);
    buf                                buf0        (X                , pwrgood_pp0_out_X    );

endmodule
