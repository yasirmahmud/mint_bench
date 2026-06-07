module sky130_fd_sc_hd__nor4b (
    Y,
    A,
    B,
    C,
    D_N,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input A;
    input B;
    input C;
    input D_N;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    // Implement the functional behavior: a four-input NOR gate with D_N as one of its inputs.
    // The '_N' suffix typically indicates an active-low or inverted input provided directly to the gate.
    assign Y = ~(A | B | C | D_N);

    // Dummy assignments to resolve 'declared but not read' warnings for power, ground, and body-bias pins.
    // These pins are for physical connection and do not affect the logical function Y.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB = VPB;
    wire _unused_VNB = VNB;

endmodule
