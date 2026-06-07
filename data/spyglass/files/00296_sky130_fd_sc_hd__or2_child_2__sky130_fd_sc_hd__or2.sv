// Definition for sky130_fd_sc_hd__or2
module sky130_fd_sc_hd__or2 (
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

    assign X = A | B;

    // Resolve W240 violations: Input declared but not read.
    // These dummy assignments ensure the power ports are 'read' by the behavioral model
    // without affecting the logical functionality (X = A | B) or the port list,
    // which is critical for physical design connectivity of standard cells.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
