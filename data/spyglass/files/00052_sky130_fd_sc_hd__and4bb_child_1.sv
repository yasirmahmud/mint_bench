module sky130_fd_sc_hd__and4bb (
    X   ,
    A_N ,
    B_N ,
    C   ,
    D   ,
    VPWR,
    VGND
);

    // Module ports
    output X   ;
    input  A_N ;
    input  B_N ;
    input  C   ;
    input  D   ;
    input  VPWR;
    input  VGND;

    // Local signals
    wire nor0_out         ;
    wire and0_out_X       ;
    wire pwrgood_pp0_out_X;

    //                                 Name         Output             Other arguments
    nor                                nor0        (nor0_out         , A_N, B_N              );
    and                                and0        (and0_out_X       , nor0_out, C, D        );
    // The sky130_fd_sc_hd__udp_pwrgood_pp$PG module is a blackbox for the linter.
    // To resolve ErrorAnalyzeBBox and preserve functional behavior (assuming good power),
    // we model its data path behavior as a simple buffer/passthrough.
    assign pwrgood_pp0_out_X = and0_out_X;
    buf                                buf0        (X                , pwrgood_pp0_out_X     );

endmodule
