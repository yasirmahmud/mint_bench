module sky130_fd_sc_hd__o41a (
    output X,
    input A1,
    input A2,
    input A3,
    input A4,
    input B1,
    input VPWR,
    input VGND,
    input VPB,
    input VNB
);
    assign X = (A1 | A2 | A3 | A4) & B1;
endmodule
