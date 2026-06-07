module sky130_fd_sc_hd__o221ai (
    Y,
    A1,
    A2,
    B1,
    B2,
    C1,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input A1, A2;
    input B1, B2;
    input C1;
    input VPWR, VGND, VPB, VNB;

    assign Y = ~((A1 | A2) & (B1 | B2) & C1);

endmodule
