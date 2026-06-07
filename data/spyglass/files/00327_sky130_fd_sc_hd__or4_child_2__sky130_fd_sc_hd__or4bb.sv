module sky130_fd_sc_hd__or4bb (
    X   ,
    A   ,
    B   ,
    C_N ,
    D_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B   ;
    input  C_N ;
    input  D_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Implement the four-input OR gate behavior with two standard and two inverted inputs
    assign X = A | B | (~C_N) | (~D_N);

    // Dummy assignment to suppress W240 warnings for unused power/ground inputs.
    // These ports are for power management and not part of the logical function X.
    // This assignment does not affect the functional output X.
    wire _unused_power_ports;
    assign _unused_power_ports = VPWR | VGND | VPB | VNB;

endmodule
