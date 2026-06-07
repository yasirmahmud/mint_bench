module sky130_fd_sc_hd__o211ai (
    Y,
    A1,
    A2,
    B1,
    C1,
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
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Functional logic for the o211ai gate. This resolves the "empty definition" warning
    // and the "input declared but not read" warnings for A1, A2, B1, C1.
    assign Y = ~((A1 | A2) & B1 & C1);

    // Dummy assignments for power/ground pins to satisfy strict linting rules (W240)
    // for inputs declared but not read. These do not affect the functional behavior
    // of the cell, as power pins are typically not involved in boolean logic computation.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
