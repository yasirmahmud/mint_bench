module sky130_fd_sc_hd__or4 (
    X   ,
    A   ,
    B   ,
    C   ,
    D   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  D   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Dummy assignment to resolve W240 violations for unused power/ground inputs
    wire _unused_power_signals;
    assign _unused_power_signals = VPWR | VGND | VPB | VNB;

    assign X = A | B | C | D;

endmodule
