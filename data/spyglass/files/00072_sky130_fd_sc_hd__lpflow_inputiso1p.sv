module sky130_fd_sc_hd__lpflow_inputiso1p (
    X    ,
    A    ,
    SLEEP,
    VPWR ,
    VGND ,
    VPB  ,
    VNB
);

    // Module ports
    output X    ;
    input  A    ;
    input  SLEEP;
    input  VPWR ;
    input  VGND ;
    input  VPB  ;
    input  VNB  ;

    // Local signals
    wire or0_out_X;

    //                                   Name      Output     Other arguments
    or                                   or0      (or0_out_X, A, SLEEP             );
    sky130_fd_sc_hd__udp_pwrgood$l_pp$PG pwrgood0 (X        , or0_out_X, VPWR, VGND);

endmodule
