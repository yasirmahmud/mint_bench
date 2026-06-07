module sky130_fd_sc_hd__o2bb2a (
    X   ,
    A1_N,
    A2_N,
    B1  ,
    B2  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output X;
    input  A1_N;
    input  A2_N;
    input  B1;
    input  B2;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // This is a stub definition for the standard cell sky130_fd_sc_hd__o2bb2a.
    // Its functional behavior is derived from the typical logic of an O2BB2A gate
    // in the sky130 library, where 'A_N' inputs are active-high to the internal AND gate.
    assign X = (A1_N & A2_N) | (B1 & B2);

endmodule
