module sky130_fd_sc_hd__o2bb2ai (
    Y,
    A1_N,
    A2_N,
    B1,
    B2,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A1_N;
    input  A2_N;
    input  B1;
    input  B2;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Combinational logic for the O2BB2AI gate with inverted A inputs
    // Y = ! ( ( (!A1_N || !A2_N) ) && (B1 || B2) )
    // This simplifies to Y = (A1_N && A2_N) || (!B1 && !B2)
    assign Y = (A1_N && A2_N) || (!B1 && !B2);

    // Dummy usage for power/ground pins to resolve 'declared but not read' linting violations.
    // These pins are essential for the physical cell but are not used in the functional logic.
    // Synthesis tools will typically optimize this dummy assignment away as it does not affect any outputs.
    wire _unused_power_ground_signals;
    assign _unused_power_ground_signals = VPWR | VGND | VPB | VNB;

endmodule
