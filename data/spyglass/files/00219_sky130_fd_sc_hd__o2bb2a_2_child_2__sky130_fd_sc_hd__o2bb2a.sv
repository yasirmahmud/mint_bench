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

    assign X = ~((~A1_N & ~A2_N) | (B1 & B2));

    wire _unused_power_dummy = VPWR ^ VGND ^ VPB ^ VNB;

endmodule
