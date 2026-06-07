// The wrapper module, renamed to match the required filename
// This module wraps the 'sky130_fd_sc_hd__o21a' standard cell.
module sky130_fd_sc_hd__o21a_child_2 ( // Renamed from sky130_fd_sc_hd__o21a_child_1
    X   ,
    A1  ,
    A2  ,
    B1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A1  ;
    input  A2  ;
    input  B1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Instance of the base cell, connecting all ports directly
    sky130_fd_sc_hd__o21a base (
        .X(X),
        .A1(A1),
        .A2(A2),
        .B1(B1),
        .VPWR(VPWR),
        .VGND(VGND),
        .VPB(VPB),
        .VNB(VNB)
    );

endmodule
