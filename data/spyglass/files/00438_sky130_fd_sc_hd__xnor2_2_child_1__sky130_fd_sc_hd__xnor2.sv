module sky130_fd_sc_hd__xnor2 (
    Y,
    A,
    B,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A;
    input  B;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Functional behavior of a 2-input XNOR gate
    assign Y = ~(A ^ B);

endmodule
