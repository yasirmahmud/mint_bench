module sky130_fd_sc_hd__xor3 (
    X   ,
    A   ,
    B   ,
    C   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output X;
    input  A;
    input  B;
    input  C;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Dummy assignments to resolve "input declared but not read" warnings.
    // These signals are used for physical power/ground connections but not
    // for logical computation within this behavioral model. Synthesis tools
    // will typically optimize away these unused wires.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

    assign X = A ^ B ^ C;

endmodule
