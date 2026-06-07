module sky130_fd_sc_hd__dlxtn (
    Q     ,
    D     ,
    GATE_N,
    VPWR  ,
    VGND  ,
    VPB   ,
    VNB
);

    // Module ports
    output Q     ;
    input  D     ;
    input  GATE_N;
    input  VPWR  ;
    input  VGND  ;
    input  VPB   ;
    input  VNB   ;

    // Local signals
    wire GATE ;
    wire buf_Q;

    //                                    Name     Output  Other arguments
    not                                   not0    (GATE  , GATE_N               );
    sky130_fd_sc_hd__udp_dlatch$P_pp$PG$N dlatch0 (buf_Q , D, GATE, , VPWR, VGND);
    buf                                   buf0    (Q     , buf_Q                );

endmodule
