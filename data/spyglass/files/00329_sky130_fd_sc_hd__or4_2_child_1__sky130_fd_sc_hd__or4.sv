module sky130_fd_sc_hd__or4 (
    output X,
    input  A,
    input  B,
    input  C,
    input  D,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);
    assign X = A | B | C | D;
endmodule
