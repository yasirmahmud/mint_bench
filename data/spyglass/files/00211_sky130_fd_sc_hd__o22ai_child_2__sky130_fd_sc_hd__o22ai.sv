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

    // Dummy assignments to resolve W240 warnings for unused inputs (VPWR, VGND, VPB, VNB).
    // These assignments do not affect the functional output Y and are for linting purposes.
    wire _unused_VPWR_ = VPWR;
    wire _unused_VGND_ = VGND;
    wire _unused_VPB_  = VPB;
    wire _unused_VNB_  = VNB;

endmodule
