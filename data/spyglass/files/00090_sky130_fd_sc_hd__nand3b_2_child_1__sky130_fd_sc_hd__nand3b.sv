module sky130_fd_sc_hd__nand3b (
    Y,
    A_N,
    B,
    C,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A_N;
    input  B;
    input  C;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Implement the 3-input NAND gate with inverted A_N input
    assign Y = ~((~A_N) & B & C);

endmodule
