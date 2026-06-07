module sky130_fd_sc_hd__or4b (
    output X   ,
    input  A   ,
    input  B   ,
    input  C   ,
    input  D_N ,
    input  VPWR,
    input  VGND,
    input  VPB ,
    input  VNB
);

    // Functional behavior: a four-input OR function with input D_N inverted.
    assign X = A | B | C | (~D_N);

endmodule
