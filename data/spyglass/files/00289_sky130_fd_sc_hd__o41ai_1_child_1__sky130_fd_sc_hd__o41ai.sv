module sky130_fd_sc_hd__o41ai (
    Y,
    A1,
    A2,
    A3,
    A4,
    B1,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input A1;
    input A2;
    input A3;
    input A4;
    input B1;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    // Implement the core logic: Y = NOT((A1 OR A2 OR A3 OR A4) AND B1)
    assign Y = ~((A1 | A2 | A3 | A4) & B1);

endmodule
