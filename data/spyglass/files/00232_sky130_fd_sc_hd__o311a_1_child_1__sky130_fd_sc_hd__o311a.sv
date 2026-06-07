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

endmodule
