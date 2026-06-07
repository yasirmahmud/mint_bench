module sky130_fd_sc_hd__o21ba (
    X   ,
    A1  ,
    A2  ,
    B1_N,
    VPWR,
    VGND
);

    // Module ports
    output X   ;
    input  A1  ;
    input  A2  ;
    input  B1_N;
    input  VPWR;
    input  VGND;

    // Local signals
    wire nor0_out         ;
    wire nor1_out_X       ;
    wire pwrgood_pp0_out_X;

    //                                 Name         Output             Other arguments
    nor                                nor0        (nor0_out         , A1, A2                );
    nor                                nor1        (nor1_out_X       , B1_N, nor0_out        );
    // Replaced undefined module 'sky130_fd_sc_hd__udp_pwrgood_pp$PG' with direct assignment
    // assuming a transparent data path for power-good conditioning in normal operation.
    assign pwrgood_pp0_out_X = nor1_out_X;
    buf                                buf0        (X                , pwrgood_pp0_out_X     );

endmodule
