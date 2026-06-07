module sky130_fd_sc_hd__nor4bb (
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
    input  VPWR; // Power connection, not logically used
    input  VGND; // Ground connection, not logically used
    input  VPB;  // Bulk power connection, not logically used
    input  VNB;  // Bulk ground connection, not logically used

    // Behavioral model for a four-input NOR gate with inputs A, B, C_N, D_N
    assign Y = ~(A | B | C_N | D_N);

    // Dummy assignment to prevent linting warnings for unused power inputs.
    // These inputs are for physical connections and are not part of the logical function.
    wire _unused_power_ports_sink;
    assign _unused_power_ports_sink = VPWR | VGND | VPB | VNB;

endmodule
