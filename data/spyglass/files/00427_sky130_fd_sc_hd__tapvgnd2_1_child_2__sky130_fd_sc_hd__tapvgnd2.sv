module sky130_fd_sc_hd__tapvgnd2 (
    VPWR,
    VGND,
    VPB,
    VNB
);
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    // Dummy assignments to resolve 'input declared but not read' and 'empty definition' warnings.
    // These assignments are functionally null for power/ground nets but satisfy linting tools.
    wire _dummy_VPWR = VPWR;
    wire _dummy_VGND = VGND;
    wire _dummy_VPB  = VPB;
    wire _dummy_VNB  = VNB;

endmodule
