module sky130_fd_sc_hd__or3b (
    X   ,
    A   ,
    B   ,
    C_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B   ;
    input  C_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    assign X = A | B | (~C_N);

    // Resolve SpyGlass W240 violations: Inputs 'VPWR', 'VGND', 'VPB', 'VNB' declared but not read.
    // These inputs are for power/ground connections and do not directly participate
    // in the logical function of the OR gate. A dummy wire is used to 'read' them
    // to satisfy linting rules without altering the functional behavior.
    wire _unused_power_signals_ = VPWR ^ VGND ^ VPB ^ VNB;

endmodule
