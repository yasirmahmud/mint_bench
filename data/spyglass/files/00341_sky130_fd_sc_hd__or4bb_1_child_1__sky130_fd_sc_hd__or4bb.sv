module sky130_fd_sc_hd__or4bb (
    X   ,
    A   ,
    B   ,
    C_N ,
    D_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output X;
    input  A;
    input  B;
    input  C_N;
    input  D_N;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // According to the description, C_N and D_N are "inverted inputs".
    // For a four-input OR gate, this means the logical values represented by C_N and D_N
    // should be inverted before participating in the OR operation.
    assign X = A | B | (~C_N) | (~D_N);

endmodule
