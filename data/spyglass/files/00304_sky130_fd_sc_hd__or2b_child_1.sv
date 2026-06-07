module sky130_fd_sc_hd__or2b (
    X   ,
    A   ,
    B_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X;
    input  A;
    input  B_N;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // This module implements a two-input OR gate with one inverted input (B_N).
    // The power and ground connections are part of the standard cell interface.
    assign X = A | B_N;

endmodule
