module sky130_fd_sc_hd__xnor3 (
    X   ,
    A   ,
    B   ,
    C   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output X   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    assign X = ~(A ^ B ^ C);

    // Linting fix for W240: Make sure power/ground inputs are 'read'.
    // These assignments do not affect functional behavior but satisfy linting tools.
    wire _dummy_vpwr = VPWR;
    wire _dummy_vgnd = VGND;
    wire _dummy_vpb = VPB;
    wire _dummy_vnb = VNB;

endmodule
