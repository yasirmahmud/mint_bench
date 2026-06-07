module sky130_fd_sc_hd__nand4b (
    Y   ,
    A_N ,
    B   ,
    C   ,
    D   ,
    VPWR,
    VGND
);

    // Module ports
    output Y   ;
    input  A_N ;
    input  B   ;
    input  C   ;
    input  D   ;
    input  VPWR;
    input  VGND;
    // Removed VPB and VNB as they were declared but not used,
    // resolving SpyGlass W240 warnings.

    // Local signals
    wire not0_out         ;
    wire nand0_out_Y      ;
    wire pwrgood_pp0_out_Y;

    // Functional logic:
    // Invert input A_N
    not                                not0        (not0_out         , A_N                    );
    // Perform 4-input NAND operation with inverted A_N
    nand                               nand0       (nand0_out_Y      , D, C, B, not0_out      );
    // Apply power-good buffer check using the defined module
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_Y, nand0_out_Y, VPWR, VGND);
    // Buffer final output
    buf                                buf0        (Y                , pwrgood_pp0_out_Y      );

endmodule
