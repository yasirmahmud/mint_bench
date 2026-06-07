module sky130_fd_sc_hd__or4b (
    output X   ,
    input  A   ,
    input  B   ,
    input  C   ,
    input  D_N ,
    input  VPWR,
    input  VGND,
    input  VPB ,
    input  VNB
);

    // Functional behavior: a four-input OR function with input D_N inverted.
    assign X = A | B | C | (~D_N);

    // Dummy assignment to consume unused power/ground/bulk inputs for linting.
    // These inputs are essential for physical design but not for logical function.
    // Synthesis tools will typically optimize this away.
    wire [3:0] _unused_pwr_gnd_ports_dummy_ ;
    assign _unused_pwr_gnd_ports_dummy_ = {VPWR, VGND, VPB, VNB};

endmodule
