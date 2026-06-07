module sky130_fd_sc_hd__xnor3 (
    output X,
    input A,
    input B,
    input C,
    input VPWR,
    input VGND,
    input VPB,
    input VNB
);
    // To resolve the WarnAnalyzeBBox violation (empty definition) and
    // W240 violations (inputs declared but not read), provide the logical implementation
    // for the XNOR gate and explicitly reference all inputs.
    assign X = ~(A ^ B ^ C);

    // Explicitly reference power and ground inputs to satisfy linting rules.
    // These assignments do not alter the logical functionality of the XNOR gate.
    wire _unused_vpwr_ = VPWR;
    wire _unused_vgnd_ = VGND;
    wire _unused_vpb_  = VPB;
    wire _unused_vnb_  = VNB;

endmodule
