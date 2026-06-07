module sky130_fd_sc_hd__nor4bb (
    Y,
    A,
    B,
    C_N,
    D_N,
    VPWR,
    VGND,
    VPB,
    VNB
);

    output Y;
    input  A;
    input  B;
    input  C_N;
    input  D_N;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Behavioral model for a 4-input NOR gate.
    // The inputs C_N and D_N are treated as regular inputs to this gate.
    // The description "four-input NOR gate with two inverted inputs" likely refers
    // to the overall functionality of the parent module, where C_N and D_N
    // are expected to be pre-inverted signals for C and D.
    assign Y = ~(A | B | C_N | D_N);

endmodule
