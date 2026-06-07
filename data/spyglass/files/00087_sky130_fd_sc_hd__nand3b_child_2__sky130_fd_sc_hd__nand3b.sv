module sky130_fd_sc_hd__nand3b (
    Y   ,
    A_N ,
    B   ,
    C   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output Y;
    input  A_N;
    input  B;
    input  C;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Behavioral model for a 3-input NAND gate with one inverted input (A_N)
    // The effective input to the NAND gate for 'A_N' is its inverse (~A_N).
    assign Y = ~((~A_N) & B & C);

    // Resolve SpyGlass W240 violations: Inputs 'VPWR', 'VGND', 'VPB', 'VNB' declared but not read.
    // These ports are essential for physical implementation in standard cells but are not logically
    // used in a purely behavioral Verilog model. Assigning them to an internal unused wire
    // satisfies the linting rule without altering the functional behavior of the module.
    wire [3:0] _unused_pwr_gnd_bias_pins_;
    assign _unused_pwr_gnd_bias_pins_ = {VPWR, VGND, VPB, VNB};

endmodule
