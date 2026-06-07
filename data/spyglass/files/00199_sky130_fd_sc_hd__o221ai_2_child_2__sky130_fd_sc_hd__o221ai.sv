module sky130_fd_sc_hd__o221ai (
    Y,
    A1,
    A2,
    B1,
    B2,
    C1,
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
    input  C1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Behavioral model for the standard cell logic
    assign Y = ~((A1 | A2) & (B1 | B2) & C1);

    // Dummy assignments to satisfy linting rules for unused power/ground/body-bias inputs.
    // These inputs are critical for physical implementation but not explicitly modeled in this behavioral description.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
