module sky130_fd_sc_hd__lpflow_inputisolatch (
    Q      ,
    D      ,
    SLEEP_B,
    VPWR   ,
    VGND   ,
    VPB    ,
    VNB
);

    // Module ports
    output Q      ;
    input  D      ;
    input  SLEEP_B;
    input  VPWR   ;
    input  VGND   ;
    input  VPB    ;
    input  VNB    ;

    // Local signals
    wire buf_Q;

    //                                     Name     Output  Other arguments
    sky130_fd_sc_hd__udp_dlatch$lP_pp$PG$N dlatch0 (buf_Q , D, SLEEP_B, 1'b0, VPWR, VGND);
    buf                                    buf0    (Q     , buf_Q                       );

endmodule
