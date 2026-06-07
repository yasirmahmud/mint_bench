module sky130_fd_sc_hd__tap (
    VPWR,
    VGND,
    VPB ,
    VNB
);
    input VPWR;
    input VGND;
    input VPB ;
    input VNB ;
    // Dummy assignments to satisfy linting tools by "reading" inputs.
    // The actual primitive functionality is provided by the technology library.
    // These assignments preserve the intended no-op behavior for simulation.
    wire _dummy_vpwr = VPWR;
    wire _dummy_vgnd = VGND;
    wire _dummy_vpb  = VPB;
    wire _dummy_vnb  = VNB;
endmodule
