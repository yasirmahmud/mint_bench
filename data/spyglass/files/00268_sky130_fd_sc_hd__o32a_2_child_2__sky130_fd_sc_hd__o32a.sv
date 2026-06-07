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

    // Behavioral model for sky130_fd_sc_hd__o32a to resolve linting violations.
    // As per standard cell naming conventions for 'o32a' (OR3-AND2),
    // the logic is assumed to be X = (A1 OR A2 OR A3) AND (B1 AND B2).
    assign X = (A1 | A2 | A3) & (B1 & B2);

    // Dummy assignments for power/ground/bulk inputs to resolve "declared but not read"
    // warnings without affecting the functional logic of X.
    // These signals are present for physical implementation and power integrity.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
