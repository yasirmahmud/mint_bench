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
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Functional logic for A311O (AND3_1_1_OR_1) standard cell
    assign X = (A1 & A2 & A3) | B1 | C1;

    // Dummy assignment to acknowledge power/ground/substrate inputs for linting.
    // These pins are typically connected but are not part of the logical function
    // in behavioral models of standard cells. This statement makes them 'read'
    // without affecting the functional output X.
    wire _unused_power_ports_read = VPWR | VGND | VPB | VNB;

endmodule
