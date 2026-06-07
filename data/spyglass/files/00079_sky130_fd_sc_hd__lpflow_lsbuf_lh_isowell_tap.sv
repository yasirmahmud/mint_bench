module sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap (
    X       ,
    A       ,
    LOWLVPWR,
    VPWR    ,
    VGND    ,
    VPB
);

    // Module ports
    output X       ;
    input  A       ;
    input  LOWLVPWR;
    input  VPWR    ;
    input  VGND    ;
    input  VPB     ;

    // Local signals
    wire pwrgood0_out_A;
    wire buf0_out_X    ;

    //                                   Name      Output          Other arguments
    sky130_fd_sc_hd__udp_pwrgood$l_pp$PG pwrgood0 (pwrgood0_out_A, A, LOWLVPWR, VGND     );
    buf                                  buf0     (buf0_out_X    , pwrgood0_out_A        );
    sky130_fd_sc_hd__udp_pwrgood$l_pp$PG pwrgood1 (X             , buf0_out_X, VPWR, VGND);

endmodule
