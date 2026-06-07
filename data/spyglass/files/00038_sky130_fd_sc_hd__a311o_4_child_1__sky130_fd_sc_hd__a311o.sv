// Definition of sky130_fd_sc_hd__a311o to resolve black-box violation
// This functional model describes the behavior of a 3-input AND, 2-input OR, followed by an inverter.
// X = ~((A1 & A2 & A3) | B1 | C1)
module sky130_fd_sc_hd__a311o (
    X   ,
    A1  ,
    A2  ,
    A3  ,
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
    input  A3  ;
    input  B1  ;
    input  C1  ;
    input  VPWR; // Power input, typically unused in functional models
    input  VGND; // Ground input, typically unused in functional models
    input  VPB ; // Power supply for p-channel bulk, typically unused in functional models
    input  VNB ; // Power supply for n-channel bulk, typically unused in functional models

    assign X = ~((A1 & A2 & A3) | B1 | C1);

endmodule
