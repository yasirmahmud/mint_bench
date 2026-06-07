module sky130_fd_sc_hd__nand4 (
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

    assign Y = ~(A & B & C & D);

    // To resolve SpyGlass W240 violations for inputs 'declared but not read',
    // assign power and ground pins to dummy wires. These assignments make the
    // inputs appear 'read' by lint tools but do not affect the logical behavior
    // and are typically optimized away by synthesis.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
