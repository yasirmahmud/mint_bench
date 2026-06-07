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

    output X;
    input  A;
    input  B;
    input  C;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    assign X = ~(A ^ B ^ C);

    // Dummy assignment to satisfy linting rules for unused power/ground ports (W240).
    // This assignment does not affect the functional output X and these signals will
    // likely be optimized away by synthesis tools as they don't drive an output.
    wire _unused_power_ground_ports_sink;
    assign _unused_power_ground_ports_sink = VPWR | VGND | VPB | VNB;

endmodule
