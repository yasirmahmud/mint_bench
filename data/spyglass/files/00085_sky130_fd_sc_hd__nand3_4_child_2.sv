module sky130_fd_sc_hd__nand3_4 (
    Y   ,
    A   ,
    B   ,
    C   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Resolve W240 warnings for unused power/ground inputs.
    // These inputs are part of the standard cell interface for physical
    // connectivity and power integrity, but do not directly influence the
    // logical behavior of the gate. Connecting them to dummy wires makes
    // them "read" by the linter without affecting functionality.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

    assign Y = ~(A & B & C);

endmodule
