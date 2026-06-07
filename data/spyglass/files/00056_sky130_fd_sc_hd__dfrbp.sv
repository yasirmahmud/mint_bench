module sky130_fd_sc_hd__dfrbp (
    Q      ,
    Q_N    ,
    CLK    ,
    D      ,
    RESET_B,
    VPWR   ,
    VGND   ,
    VPB    ,
    VNB
);

    // Module ports
    output Q      ;
    output Q_N    ;
    input  CLK    ;
    input  D      ;
    input  RESET_B;
    input  VPWR   ;
    input  VGND   ;
    input  VPB    ;
    input  VNB    ;

    // Local signals
    wire buf_Q;
    wire RESET;

    //                                  Delay       Name  Output  Other arguments
    not                                             not0 (RESET , RESET_B                    );
    sky130_fd_sc_hd__udp_dff$PR_pp$PG$N `UNIT_DELAY dff0 (buf_Q , D, CLK, RESET, , VPWR, VGND);
    buf                                             buf0 (Q     , buf_Q                      );
    not                                             not1 (Q_N   , buf_Q                      );

endmodule
