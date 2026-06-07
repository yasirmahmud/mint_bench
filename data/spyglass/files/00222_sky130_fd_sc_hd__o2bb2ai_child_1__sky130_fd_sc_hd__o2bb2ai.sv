module sky130_fd_sc_hd__o2bb2ai (
    Y,
    A1_N,
    A2_N,
    B1,
    B2,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A1_N;
    input  A2_N;
    input  B1;
    input  B2;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Combinational logic for the O2BB2AI gate with inverted A inputs
    // Y = ! ( ( (!A1_N || !A2_N) ) && (B1 || B2) )
    // This simplifies to Y = (A1_N && A2_N) || (!B1 && !B2)
    assign Y = (A1_N && A2_N) || (!B1 && !B2);

endmodule
