module sky130_fd_sc_hd__nand3 (
    Y   ,
    A   ,
    B   ,
    C   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output Y   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire nand0_out_Y      ;
    wire pwrgood_pp0_out_Y;

    //                                 Name         Output             Other arguments
    nand                               nand0       (nand0_out_Y      , B, A, C                );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_Y, nand0_out_Y, VPWR, VGND);
    buf                                buf0        (Y                , pwrgood_pp0_out_Y      );

endmodule
