module sky130_fd_sc_hd__lpflow_inputiso0p (
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
    wire sleepn    ;
    wire and0_out_X;

    //                                   Name      Output      Other arguments
    not                                  not0     (sleepn    , SLEEP                 );
    and                                  and0     (and0_out_X, A, sleepn             );
    sky130_fd_sc_hd__udp_pwrgood$l_pp$PG pwrgood0 (X         , and0_out_X, VPWR, VGND);

endmodule
