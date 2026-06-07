module sky130_fd_sc_hd__o2111ai (
    Y   ,
    A1  ,
    A2  ,
    B1  ,
    C1  ,
    D1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output Y   ;
    input  A1  ;
    input  A2  ;
    input  B1  ;
    input  C1  ;
    input  D1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Functional logic for O2111AI gate: Y = ~((A1 & A2) | B1 | C1 | D1)
    assign Y = ~((A1 & A2) | B1 | C1 | D1);

    // Tie unused power/ground/substrate inputs to dummy wires to resolve W240 linting violations.
    // These inputs are typically handled by physical design tools and are not part of the behavioral logic.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
