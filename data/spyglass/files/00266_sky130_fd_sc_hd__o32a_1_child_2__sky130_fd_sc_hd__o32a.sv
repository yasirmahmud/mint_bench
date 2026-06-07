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

    assign X = (A1 | A2 | A3) & (B1 | B2);

    // Fix for W240: Inputs VPWR, VGND, VPB, VNB are declared but not explicitly read in the logical expression.
    // These are power/ground signals vital for physical implementation but not for the logical 'assign' statement.
    // Dummy assignments are added to satisfy the linter without affecting functional behavior.
    wire _unused_vpwr = VPWR;
    wire _unused_vgnd = VGND;
    wire _unused_vpb  = VPB;
    wire _unused_vnb  = VNB;

endmodule // sky130_fd_sc_hd__o32a
