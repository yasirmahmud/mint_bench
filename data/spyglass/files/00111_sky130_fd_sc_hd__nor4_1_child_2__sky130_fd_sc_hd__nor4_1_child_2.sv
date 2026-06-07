// Original module which instantiates the base NOR4 cell, renamed to sky130_fd_sc_hd__nor4_1_child_2
module sky130_fd_sc_hd__nor4_1_child_2 (
    Y   ,
    A   ,
    B   ,
    C   ,
    D   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  D   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Dummy assignments to avoid W240 warnings for unused power inputs.
    // These inputs are typically for physical design and are not logically consumed by this module's logic.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

    // Instantiate the defined base NOR4 cell
    // Power ports are removed from the instantiation as the base cell is now purely logical.
    sky130_fd_sc_hd__nor4 base (
        .Y(Y),
        .A(A),
        .B(B),
        .C(C),
        .D(D)
    );

endmodule
