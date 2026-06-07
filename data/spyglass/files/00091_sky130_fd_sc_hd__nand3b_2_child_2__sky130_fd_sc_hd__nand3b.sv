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

    // Suppress W240 warnings for unused power pins by 'reading' them
    // These pins are functionally critical for physical implementation
    // but do not participate in the logical computation of Y.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
