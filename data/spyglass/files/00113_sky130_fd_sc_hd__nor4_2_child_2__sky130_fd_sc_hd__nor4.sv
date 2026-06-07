module sky130_fd_sc_hd__nor4 (
    Y,
    A,
    B,
    C,
    D,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A;
    input  B;
    input  C;
    input  D;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    assign Y = ~(A | B | C | D);

    // Dummy assignments to suppress unused input warnings for power/ground/bulk signals.
    // These signals are part of the physical interface for standard cells 
    // but do not directly participate in the gate's logical function.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
