module sky130_fd_sc_hd__o31a (
    X   ,
    A1  ,
    A2  ,
    A3  ,
    B1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X;
    input  A1;
    input  A2;
    input  A3;
    input  B1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    assign X = (A1 | A2 | A3) & B1;

    // Resolve SpyGlass W240 violations for unused power/ground inputs
    // by reading them into a dummy wire. This wire will be optimized out by synthesis.
    wire _sg_unused_pins_;
    assign _sg_unused_pins_ = VPWR | VGND | VPB | VNB;

endmodule
