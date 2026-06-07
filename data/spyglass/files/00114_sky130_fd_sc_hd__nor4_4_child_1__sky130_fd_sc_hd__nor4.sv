module sky130_fd_sc_hd__nor4 (
    output Y,
    input  A,
    input  B,
    input  C,
    input  D,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);
    // Implement the 4-input NOR function for the base cell
    assign Y = ~(A | B | C | D);
endmodule
