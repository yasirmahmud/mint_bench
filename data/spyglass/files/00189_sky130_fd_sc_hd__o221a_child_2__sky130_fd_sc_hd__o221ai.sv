module sky130_fd_sc_hd__o221ai (
    Y   ,
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

    output Y   ;
    input  A1  ;
    input  A2  ;
    input  B1  ;
    input  B2  ;
    input  C1  ;
    supply1  VPWR; // Changed from input to supply1 to indicate power rail
    supply0  VGND; // Changed from input to supply0 to indicate ground rail
    supply1  VPB ;  // Changed from input to supply1 to indicate p-bulk connection
    supply0  VNB ;  // Changed from input to supply0 to indicate n-bulk connection

    // O221AI gate logic: Y = !(((A1 | A2) & (B1 | B2)) & C1)
    assign Y = ~((A1 | A2) & (B1 | B2) & C1);

endmodule
