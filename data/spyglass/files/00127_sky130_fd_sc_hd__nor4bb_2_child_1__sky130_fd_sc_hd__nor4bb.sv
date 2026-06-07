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

    // Behavioral model for a 4-input NOR gate with mixed active-high/low inputs
    // Y = NOT (A OR B OR (NOT C_N) OR (NOT D_N))
    assign Y = ~ (A | B | (~C_N) | (~D_N));

endmodule
