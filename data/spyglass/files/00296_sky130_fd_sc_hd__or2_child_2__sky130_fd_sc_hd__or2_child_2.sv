// Wrapper module for sky130_fd_sc_hd__or2
// Renamed from sky130_fd_sc_hd__or2_1 to sky130_fd_sc_hd__or2_child_2 as per design label.
module sky130_fd_sc_hd__or2_child_2 (
    X   ,
    A   ,
    B   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    sky130_fd_sc_hd__or2 base (
        .X(X),
        .A(A),
        .B(B),
        .VPWR(VPWR),
        .VGND(VGND),
        .VPB(VPB),
        .VNB(VNB)
    );

endmodule
