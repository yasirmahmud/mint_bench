module sky130_fd_sc_hd__o41ai (
    Y   ,
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
    output Y   ;
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
    wire or0_out          ;
    wire nand0_out_Y      ;
    wire pwrgood_pp0_out_Y;

    //                                 Name         Output             Other arguments
    or                                 or0         (or0_out          , A4, A3, A2, A1         );
    nand                               nand0       (nand0_out_Y      , B1, or0_out            );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_Y, nand0_out_Y, VPWR, VGND);
    buf                                buf0        (Y                , pwrgood_pp0_out_Y      );

endmodule
