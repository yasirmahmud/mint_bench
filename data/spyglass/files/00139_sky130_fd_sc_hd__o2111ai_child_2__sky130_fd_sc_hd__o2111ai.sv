module sky130_fd_sc_hd__o2111ai (
    Y,
    A1,
    A2,
    B1,
    C1,
    D1,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A1;
    input  A2;
    input  B1;
    input  C1;
    input  D1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Behavioral model for O2111AI: Y = ~ ( (A1 | A2) & B1 & C1 & D1 )
    // This definition resolves the 'ErrorAnalyzeBBox' violation by providing
    // the expected black-box definition to the linting tool.
    assign Y = ~ ( (A1 | A2) & B1 & C1 & D1 );

    // Fix for W240: Dummy assignment to acknowledge power pins for linting.
    // These inputs are critical for physical implementation but are not part of the logical function.
    wire _lint_unused_power_pins;
    assign _lint_unused_power_pins = VPWR ^ VGND ^ VPB ^ VNB;

endmodule
