module sky130_fd_sc_hd__o211a (
    X   ,
    A1  ,
    A2  ,
    B1  ,
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
    input  C1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Implement the O211A gate functionality to resolve 'empty definition' and 'input not read' for functional inputs.
    // An O211A gate typically performs: NOT(((A1 OR A2) AND B1) AND C1)
    assign X = ~(((A1 | A2) & B1) & C1);

    // Dummy assignment to resolve 'input not read' warnings for power pins.
    // In physical standard cells, these pins are used for power delivery, but in a behavioral model,
    // they might not be explicitly 'read' by logic, leading to linter warnings.
    // This assignment ensures they are considered 'read' without affecting functional behavior.
    wire _unused_power_pins_read_ = VPWR | VGND | VPB | VNB;

endmodule
