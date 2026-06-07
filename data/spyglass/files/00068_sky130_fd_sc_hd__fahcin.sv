module sky130_fd_sc_hd__fahcin (
    COUT,
    SUM ,
    A   ,
    B   ,
    CIN ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output COUT;
    output SUM ;
    input  A   ;
    input  B   ;
    input  CIN ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire ci                  ;
    wire xor0_out_SUM        ;
    wire pwrgood_pp0_out_SUM ;
    wire a_b                 ;
    wire a_ci                ;
    wire b_ci                ;
    wire or0_out_COUT        ;
    wire pwrgood_pp1_out_COUT;

    //                                 Name         Output                Other arguments
    not                                not0        (ci                  , CIN                     );
    xor                                xor0        (xor0_out_SUM        , A, B, ci                );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_SUM , xor0_out_SUM, VPWR, VGND);
    buf                                buf0        (SUM                 , pwrgood_pp0_out_SUM     );
    and                                and0        (a_b                 , A, B                    );
    and                                and1        (a_ci                , A, ci                   );
    and                                and2        (b_ci                , B, ci                   );
    or                                 or0         (or0_out_COUT        , a_b, a_ci, b_ci         );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp1 (pwrgood_pp1_out_COUT, or0_out_COUT, VPWR, VGND);
    buf                                buf1        (COUT                , pwrgood_pp1_out_COUT    );

endmodule
