module sky130_fd_sc_hd__tap (
    VPWR,
    VGND,
    VPB,
    VNB
);
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    // Fix: Add dummy assignments to 'use' the inputs and resolve 'empty definition' violations.
    // This preserves functional behavior as tap cells are passive, connecting power and ground.
    wire dummy_vpwr = VPWR;
    wire dummy_vgnd = VGND;
    wire dummy_vpb  = VPB;
    wire dummy_vnb  = VNB;
endmodule
