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
    input A1;
    input A2;
    input B1;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    // Functional logic for an OAI21 cell: Y = ~((A1 | A2) & B1)
    assign Y = ~((A1 | A2) & B1);

    // Dummy assignments to avoid 'input declared but not read' warnings for power pins.
    // These assignments do not affect the functional logic of the cell and are typically
    // ignored by synthesis tools for standard cell library models.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
