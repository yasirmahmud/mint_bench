module sky130_fd_sc_hd__o21bai (
    Y,
    A1,
    A2,
    B1_N,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A1;
    input  A2;
    input  B1_N;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Functional behavior for OAI21 cell with active-low B1_N input:
    // Y = ~((A1 | A2) & B1), where B1 is the active high input to the AND gate.
    // Since B1_N is the input, B1 = ~B1_N.
    assign Y = ~((A1 | A2) & (~B1_N));

endmodule
