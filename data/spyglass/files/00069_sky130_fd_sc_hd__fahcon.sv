module sky130_fd_sc_hd__fahcon (
    COUT_N,
    SUM   ,
    A     ,
    B     ,
    CI    ,
    VPWR  ,
    VGND  ,
    VPB   ,
    VNB
);

    // Module ports
    output COUT_N;
    output SUM   ;
    input  A     ;
    input  B     ;
    input  CI    ;
    input  VPWR  ;
    input  VGND  ;
    input  VPB   ;
    input  VNB   ;

    // Local signals
    wire xor0_out_SUM         ;
    wire pwrgood_pp0_out_SUM  ;
    wire a_b                  ;
    wire a_ci                 ;
    wire b_ci                 ;
    wire or0_out_coutn        ;
    wire pwrgood_pp1_out_coutn;

    //                                 Name         Output                 Other arguments
    xor                                xor0        (xor0_out_SUM         , A, B, CI                 );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_SUM  , xor0_out_SUM, VPWR, VGND );
    buf                                buf0        (SUM                  , pwrgood_pp0_out_SUM      );
    nor                                nor0        (a_b                  , A, B                     );
    nor                                nor1        (a_ci                 , A, CI                    );
    nor                                nor2        (b_ci                 , B, CI                    );
    or                                 or0         (or0_out_coutn        , a_b, a_ci, b_ci          );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp1 (pwrgood_pp1_out_coutn, or0_out_coutn, VPWR, VGND);
    buf                                buf1        (COUT_N               , pwrgood_pp1_out_coutn    );

endmodule
