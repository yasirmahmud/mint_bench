module sky130_fd_sc_hd__o311ai (
    Y,
    A1,
    A2,
    A3,
    B1,
    C1,
    VPWR,
    VGND,
    VPB,
    VNB
);

    output Y   ;
    input  A1  ;
    input  A2  ;
    input  A3  ;
    input  B1  ;
    input  C1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Functional behavior: inversely combining three A inputs with B1 and C1 signals
    // Standard cell name 'o311ai' suggests OR(A1, A2, A3) AND B1 AND C1, then Inverted
    assign Y = ~((A1 | A2 | A3) & B1 & C1);

    // Linting fix for W240: Make power/ground inputs as 'read' without affecting functional logic.
    // These ports are required for physical design but do not participate in logical computation.
    wire _unused_ports_sg;
    assign _unused_ports_sg = VPWR & VGND & VPB & VNB;

endmodule
