module sky130_fd_sc_hd__o21ai (
    Y,
    A1,
    A2,
    B1,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A1;
    input  A2;
    input  B1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Functional behavior: Y = !((A1 & A2) | B1)
    assign Y = ~((A1 & A2) | B1);

    // Lint fix: Dummy usage for power/ground/substrate pins.
    // These pins are typically connected to supply rails and not used in logical operations.
    // This assignment makes them "read" by the design to satisfy linting rules (W240)
    // without affecting the functional behavior of output Y.
    wire _lint_fix_dummy_read_ = VPWR | VGND | VPB | VNB;

endmodule
