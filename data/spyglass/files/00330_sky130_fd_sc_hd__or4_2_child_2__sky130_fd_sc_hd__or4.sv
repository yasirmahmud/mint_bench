module sky130_fd_sc_hd__or4 (
    output X,
    input  A,
    input  B,
    input  C,
    input  D,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);
    assign X = A | B | C | D;
    wire _unused_vpyr = VPWR;
    wire _unused_vgnd = VGND;
    wire _unused_vpb = VPB;
    wire _unused_vnb = VNB;
endmodule
