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

    // Logic function: Y = !((A1 || A2) && !B1_N)
    // This effectively computes the NAND of (A1 OR A2) with the inverted B1_N.
    // Using Verilog bitwise operators for single-bit signals:
    assign Y = ~((A1 | A2) & ~B1_N);

endmodule
