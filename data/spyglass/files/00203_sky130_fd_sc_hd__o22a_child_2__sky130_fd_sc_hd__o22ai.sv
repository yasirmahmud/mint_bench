module sky130_fd_sc_hd__o22ai (
    Y   ,
    A1  ,
    A2  ,
    B1  ,
    B2  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output Y   ;
    input  A1  ;
    input  A2  ;
    input  B1  ;
    input  B2  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Resolve W240 violations for unused power/ground inputs.
    // These signals are connected for physical layout and power delivery,
    // but not directly used in the logical assignment for Y.
    // Assigning them to dummy wires makes them 'read' by lint tools without
    // altering functional behavior.
    wire _unused_vpwr = VPWR;
    wire _unused_vgnd = VGND;
    wire _unused_vpb = VPB;
    wire _unused_vnb = VNB;

    assign Y = ~((A1 & A2) | (B1 & B2));

endmodule
