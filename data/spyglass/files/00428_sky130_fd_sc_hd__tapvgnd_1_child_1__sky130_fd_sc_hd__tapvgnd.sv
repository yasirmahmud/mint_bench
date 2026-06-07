// Dummy module definition to resolve SpyGlass ErrorAnalyzeBBox violation
// This provides the interface for the base cell without defining its internal logic,
// preserving its intended black-box behavior for functional design while satisfying the linter.
module sky130_fd_sc_hd__tapvgnd (
    VPWR,
    VGND,
    VPB ,
    VNB
);
    inout VPWR;
    inout VGND;
    inout VPB ;
    inout VNB ;
endmodule // sky130_fd_sc_hd__tapvgnd
