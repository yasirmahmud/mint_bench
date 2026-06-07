module sky130_fd_sc_hd__o211a (
    X   ,
    A1  ,
    A2  ,
    B1  ,
    C1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output X   ;
    input  A1  ;
    input  A2  ;
    input  B1  ;
    input  C1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire or0_out          ;
    wire and0_out_X       ;
    wire pwrgood_pp0_out_X;

    //                                 Name         Output             Other arguments
    or                                 or0         (or0_out          , A2, A1                );
    and                                and0        (and0_out_X       , or0_out, B1, C1       );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_X, and0_out_X, VPWR, VGND);
    buf                                buf0        (X                , pwrgood_pp0_out_X     );

endmodule
