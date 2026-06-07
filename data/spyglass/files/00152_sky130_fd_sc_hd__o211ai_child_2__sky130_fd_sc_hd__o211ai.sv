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
    input A1;
    input A2;
    input B1;
    input C1;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    // Behavioral model for simulation and linting purposes.
    // The actual logic is implemented in a separate technology library.
    // This resolves the 'Design Unit ... has empty definition' warning (ID 14)
    // and 'input declared but not read' for A1, A2, B1, C1 (IDs 3, 4, 5, 6).
    assign Y = ~((A1 & A2) | B1 | C1);

    // Suppress 'input declared but not read' warnings for power/ground pins
    // (IDs A, 7, 9, 8) by explicitly using them in a dummy assignment.
    // This does not affect the functional logic of output Y.
    wire _unused_power_pins;
    assign _unused_power_pins = VPWR | VGND | VPB | VNB;

endmodule
