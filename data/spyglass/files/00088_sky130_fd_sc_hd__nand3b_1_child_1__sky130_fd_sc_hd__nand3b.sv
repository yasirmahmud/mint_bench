// Definition of the black-boxed module 'sky130_fd_sc_hd__nand3b'
// This provides the functional definition for the instantiated gate,
// resolving the 'ErrorAnalyzeBBox' violation.
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
    input  VPWR; // Power input
    input  VGND; // Ground input
    input  VPB;  // Bulk power input (for p-type transistors)
    input  VNB;  // Bulk ground input (for n-type transistors)

    // Implement the behavior of a three-input NAND gate with one active-low input (A_N)
    // Y = NOT ( (NOT A_N) AND B AND C )
    assign Y = ~((~A_N) & B & C);

endmodule
