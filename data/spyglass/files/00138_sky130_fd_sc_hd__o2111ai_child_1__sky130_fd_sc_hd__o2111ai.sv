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

endmodule
