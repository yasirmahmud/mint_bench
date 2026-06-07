module sky130_fd_sc_hd__o32ai (
    Y,
    A1,
    A2,
    A3,
    B1,
    B2,
    VPWR,
    VGND,
    VPB,
    VNB
);

    output Y;
    input  A1;
    input  A2;
    input  A3;
    input  B1;
    input  B2;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Functional behavior: Inverted AND of (OR of A1, A2, A3) and (OR of B1, B2)
    assign Y = ~(((A1 | A2 | A3) & (B1 | B2)));

    // Resolve SpyGlass W240 warnings for unused power/ground inputs.
    // These inputs are present for physical power/ground connections
    // and do not impact the logical behavior of the gate, so they are
    // assigned to dummy wires to be 'read' by linting tools.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
