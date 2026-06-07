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

    // Fix for W240 (Input declared but not read) violations for power/ground pins.
    // These pins are physically relevant but not logically used in the behavioral model.
    // A dummy assignment makes the linter consider them 'read' without affecting functionality.
    wire _unused_power_signals;
    assign _unused_power_signals = VPWR & VGND & VPB & VNB;

endmodule
