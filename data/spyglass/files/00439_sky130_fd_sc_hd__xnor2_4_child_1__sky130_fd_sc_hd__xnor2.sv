// Definition of the instantiated module to resolve ErrorAnalyzeBBox
module sky130_fd_sc_hd__xnor2 (
    output Y,
    input  A,
    input  B,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);
    // Behavioral model for XNOR gate
    assign Y = ~(A ^ B);
endmodule
