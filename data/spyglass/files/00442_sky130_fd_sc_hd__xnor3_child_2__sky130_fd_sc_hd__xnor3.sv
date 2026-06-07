// Behavioral definition for the base XNOR3 cell to resolve the black-box violation.
// This definition implements a 3-input XNOR gate: X = ~(A ^ B ^ C).
module sky130_fd_sc_hd__xnor3 (
    X   ,
    A   ,
    B   ,
    C   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B   ;
    input  C   ;
    (* unused *) input  VPWR; // Power pins are included for compatibility with physical cells but unused in behavioral model.
    (* unused *) input  VGND;
    (* unused *) input  VPB ;
    (* unused *) input  VNB ;

    assign X = ~(A ^ B ^ C);

endmodule // sky130_fd_sc_hd__xnor3
