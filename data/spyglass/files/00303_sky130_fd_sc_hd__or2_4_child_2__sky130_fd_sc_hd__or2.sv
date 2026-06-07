module sky130_fd_sc_hd__or2 (
    X   ,
    A   ,
    B   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Dummy assignment to consume power/ground inputs and satisfy linter W240.
    // These inputs are for physical power connections and do not affect logical behavior.
    wire [3:0] _unused_pwr_gnd = {VPWR, VGND, VPB, VNB};

    assign X = A | B;

endmodule
