module sky130_fd_sc_hd__o32a (
    X   ,
    A1  ,
    A2  ,
    A3  ,
    B1  ,
    B2  ,
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
    input  B2  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Dummy assignment to prevent W240 (unused input) violations for power pins.
    // These pins define the physical interface but do not contribute to the logical function.
    // This assignment has no functional impact on the output X and will be optimized out by synthesis.
    wire _unused_power_pins_net_;
    assign _unused_power_pins_net_ = VPWR | VGND | VPB | VNB;

    assign X = (A1 | A2 | A3) & (B1 & B2);

endmodule
