module sky130_fd_sc_hd__sdfrtn (
    Q      ,
    CLK_N  ,
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
    input  CLK_N  ;
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
    wire intclk ;
    wire mux_out;

    //                                  Delay       Name       Output   Other arguments
    not                                             not0      (RESET  , RESET_B                             );
    not                                             not1      (intclk , CLK_N                               );
    sky130_fd_sc_hd__udp_mux_2to1                   mux_2to10 (mux_out, D, SCD, SCE                         );
    sky130_fd_sc_hd__udp_dff$PR_pp$PG$N `UNIT_DELAY dff0      (buf_Q  , mux_out, intclk, RESET, , VPWR, VGND);
    buf                                             buf0      (Q      , buf_Q                               );

endmodule
