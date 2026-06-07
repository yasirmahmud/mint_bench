module sky130_fd_sc_hd__nor4bb (
    Y   ,
    A   ,
    B   ,
    C_N ,
    D_N ,
    VPWR,
    VGND,
    VPB ,
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

    // This module implements a four-input NOR gate where C_N and D_N are
    // considered to be pre-inverted inputs (active-low).
    // The logic is Y = ~(A | B | C_N | D_N).
    assign Y = ~(A | B | C_N | D_N);

endmodule
