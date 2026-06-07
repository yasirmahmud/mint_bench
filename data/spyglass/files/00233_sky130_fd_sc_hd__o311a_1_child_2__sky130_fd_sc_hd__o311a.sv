module sky130_fd_sc_hd__o311a (
    X,
    A1,
    A2,
    A3,
    B1,
    C1,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output X;
    input A1, A2, A3;
    input B1;
    input C1;
    input VPWR, VGND, VPB, VNB;

    // Functional behavior for o311a gate: X = (A1 | A2 | A3) & B1 & C1
    assign X = (A1 | A2 | A3) & B1 & C1;

    // Dummy assignment to consume power and ground inputs to satisfy linting rules.
    // These assignments do not affect the functional behavior of output X.
    wire _unused_pwr_gnd_signals_ = VPWR | VGND | VPB | VNB;

endmodule
