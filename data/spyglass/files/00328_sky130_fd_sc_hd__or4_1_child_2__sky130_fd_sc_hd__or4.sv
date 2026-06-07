module sky130_fd_sc_hd__or4 (
    X, A, B, C, D, VPWR, VGND, VPB, VNB
);
    output X;
    input A, B, C, D;
    input VPWR, VGND, VPB, VNB;
    assign X = A | B | C | D;
endmodule
