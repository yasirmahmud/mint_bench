module sky130_fd_sc_hd__maj3 (
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
    wire or0_out          ;
    wire and0_out         ;
    wire and1_out         ;
    wire or1_out_X        ;
    wire pwrgood_pp0_out_X;

    //                                 Name         Output             Other arguments
    or                                 or0         (or0_out          , B, A                 );
    and                                and0        (and0_out         , or0_out, C           );
    and                                and1        (and1_out         , A, B                 );
    or                                 or1         (or1_out_X        , and1_out, and0_out   );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_X, or1_out_X, VPWR, VGND);
    buf                                buf0        (X                , pwrgood_pp0_out_X    );

endmodule
