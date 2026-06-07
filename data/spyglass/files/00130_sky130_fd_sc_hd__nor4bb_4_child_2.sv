module sky130_fd_sc_hd__nor4bb_4_child_2 (
    Y,
    A,
    B,
    C_N,
    D_N,
    VPWR,
    VGND,
    VPB,
    VNB
);

    output Y;
    input  A;
    input  B;
    input  C_N;
    input  D_N;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Behavioral model for a 4-input NOR gate.
    // The inputs C_N and D_N are treated as regular inputs to this gate.
    assign Y = ~(A | B | C_N | D_N);

    // To resolve SpyGlass W240 warnings for declared but not read inputs
    // (VPWR, VGND, VPB, VNB), a dummy assignment is added.
    // These power/ground pins are essential for the physical cell definition
    // but are not part of the logical behavioral model's calculation.
    // This assignment provides a 'read' reference for the linter without
    // affecting the functional behavior of the NOR gate. Synthesis tools
    // typically optimize away such unused logic.
    wire _unused_power_signals = VPWR | VGND | VPB | VNB;

endmodule
