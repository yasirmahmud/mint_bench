module sky130_fd_sc_hd__o221a (
    X   ,
    A1  ,
    A2  ,
    B1  ,
    B2  ,
    C1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A1  ;
    input  A2  ;
    input  B1  ;
    input  B2  ;
    input  C1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    assign X = (A1 | A2) & (B1 | B2) & C1;

    // Fix for SpyGlass W240 violations: Dummy assignment to acknowledge power/ground inputs.
    // This ensures they are considered 'read' by the linter without affecting functional behavior.
    wire _unused_power_inputs_w240_fix;
    assign _unused_power_inputs_w240_fix = VPWR | VGND | VPB | VNB;

endmodule
