module sky130_fd_sc_hd__o22ai (
    Y,
    A1,
    A2,
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
    input  B1;
    input  B2;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Dummy assignments to consume power/ground inputs for linting purposes.
    // These inputs are critical for physical design but not explicitly used in
    // the functional logic for RTL simulation, hence they are often flagged as unused.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

    // Functional behavior: Y = ~((A1 AND A2) OR (B1 AND B2))
    assign Y = ~((A1 & A2) | (B1 & B2));

endmodule
