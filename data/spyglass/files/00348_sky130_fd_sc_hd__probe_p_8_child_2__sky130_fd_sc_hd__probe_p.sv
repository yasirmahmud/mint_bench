module sky130_fd_sc_hd__probe_p (
    X,
    A,
    VGND,
    VNB,
    VPB,
    VPWR
);
    output X;
    input  A;
    input  VGND;
    input  VNB;
    input  VPB;
    input  VPWR;

    assign X = A;

    // SpyGlass W240: Dummy assignments for unused power/ground inputs
    // These inputs are essential for physical implementation but are not logically 'read'
    // in the functional Verilog model. This change preserves functional behavior.
    wire _sg_fix_vgnd = VGND;
    wire _sg_fix_vnb  = VNB;
    wire _sg_fix_vpb  = VPB;
    wire _sg_fix_vpwr = VPWR;

endmodule
