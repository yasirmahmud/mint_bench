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

endmodule
