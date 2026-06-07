module sky130_fd_sc_hd__nor4bb (
    output Y,
    input  A,
    input  B,
    input  C_N,
    input  D_N,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);
    // Behavioral model for a 4-input NOR gate with two inverted inputs.
    // Y = ~(A | B | C_N | D_N)
    assign Y = ~(A | B | C_N | D_N);
endmodule
