module sky130_fd_sc_hd__or3b (
    X,
    A,
    B,
    C_N,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output X;
    input  A;
    input  B;
    input  C_N;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Functional behavior: 3-input OR gate with one inverted input (C_N)
    assign X = A | B | (~C_N);

    // Linting workaround: Dummy assignment to avoid W240 for unused power/ground inputs.
    // These inputs are essential for physical design connectivity but do not
    // directly affect the logical behavior of this simple gate in its behavioral model.
    wire _unused_pwr_gnd_pins;
    assign _unused_pwr_gnd_pins = VPWR & VGND & VPB & VNB;

endmodule
