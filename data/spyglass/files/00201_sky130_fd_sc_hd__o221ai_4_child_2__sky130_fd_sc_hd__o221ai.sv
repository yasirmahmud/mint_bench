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
    input A1, A2;
    input B1, B2;
    input C1;
    input VPWR, VGND, VPB, VNB;

    // Resolve SpyGlass W240 warnings for unused power/ground/bulk inputs.
    // These inputs are critical for physical implementation but are not
    // actively used in logical assignments within this Verilog model.
    // Assigning them to dummy wires satisfies the linting tool without
    // changing the functional behavior of the gate.
    wire _sg_unused_vpwr = VPWR;
    wire _sg_unused_vgnd = VGND;
    wire _sg_unused_vpb = VPB;
    wire _sg_unused_vnb = VNB;

    assign Y = ~((A1 | A2) & (B1 | B2) & C1);

endmodule
