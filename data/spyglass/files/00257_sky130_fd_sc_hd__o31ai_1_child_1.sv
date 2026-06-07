module sky130_fd_sc_hd__o31ai (
    Y,
    A1,
    A2,
    A3,
    B1,
    VPWR,
    VGND,
    VPB,
    VNB
);

    output Y;
    input  A1;
    input  A2;
    input  A3;
    input  B1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Behavioral model for o31ai (OR3-1 AND-INVERT) gate
    // Y = NOT ( (A1 AND A2 AND A3) OR B1 )
    assign Y = ~((A1 & A2 & A3) | B1);

endmodule
