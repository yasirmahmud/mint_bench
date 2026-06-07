module sky130_fd_sc_hd__o22ai (
    Y,
    A1,
    A2,
    B1,
    B2,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A1;
    input  A2;
    input  B1;
    input  B2;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // The O22AI cell implements Y = ~((A1 | A2) & (B1 | B2)).
    // Power/ground/substrate pins are typically for physical implementation
    // and are declared as inputs in the RTL model for completeness.
    assign Y = ~((A1 | A2) & (B1 | B2));

endmodule
