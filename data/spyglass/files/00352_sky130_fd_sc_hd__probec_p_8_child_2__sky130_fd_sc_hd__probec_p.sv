module sky130_fd_sc_hd__probec_p (
    X,
    A,
    VGND,
    VNB,
    VPB,
    VPWR
);
    output X;
    input A;
    input VGND;
    input VNB;
    input VPB;
    input VPWR;

    // To resolve "Design Unit 'sky130_fd_sc_hd__probec_p' has empty definition" (WarnAnalyzeBBox)
    // and "Input 'A' declared but not read" (W240 for A).
    // For a probe cell, a buffer is a common minimal functional representation.
    assign X = A;

    // To resolve "Input 'VGND/VNB/VPB/VPWR' declared but not read" (W240).
    // Assigning to dummy wires satisfies the linter without affecting functional behavior
    // for these power/ground supply pins in a black-box definition.
    wire _unused_vgnd_pin = VGND;
    wire _unused_vnb_pin = VNB;
    wire _unused_vpb_pin = VPB;
    wire _unused_vpwr_pin = VPWR;

endmodule
