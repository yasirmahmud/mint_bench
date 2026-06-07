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

    output X   ;
    input  A1  ;
    input  A2  ;
    input  A3  ;
    input  B1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Functional behavior: ORs three inputs and then ANDs the result with a fourth input
    assign X = (A1 | A2 | A3) & B1;

    // Resolve SpyGlass W240 violations for unused power/ground pins.
    // These pins are physically essential for standard cells but are not directly
    // used in the logical function. A dummy assignment ensures they are "read"
    // by the linter without affecting functional behavior after synthesis.
    wire _unused_power_pins_sg;
    assign _unused_power_pins_sg = VPWR & VGND & VPB & VNB;

endmodule
