module sky130_fd_sc_hd__sdfrtp (
    Q      ,
    CLK    ,
    D      ,
    SCD    ,
    SCE    ,
    RESET_B,
    VPWR   ,
    VGND   ,
    VPB    ,
    VNB
);

    // Module ports
    output Q      ;
    input  CLK    ;
    input  D      ;
    input  SCD    ;
    input  SCE    ;
    input  RESET_B;
    input  VPWR   ;
    input  VGND   ;
    input  VPB    ;
    input  VNB    ;

    // Local signals
    wire buf_Q  ;
    wire RESET  ;
    wire mux_out;

    //                                  Delay       Name       Output   Other arguments
    not                                             not0      (RESET  , RESET_B                          );
    sky130_fd_sc_hd__udp_mux_2to1                   mux_2to10 (mux_out, D, SCD, SCE                      );
    sky130_fd_sc_hd__udp_dff$PR_pp$PG$N `UNIT_DELAY dff0      (buf_Q  , mux_out, CLK, RESET, , VPWR, VGND);
    buf                                             buf0      (Q      , buf_Q                            );

endmodule
