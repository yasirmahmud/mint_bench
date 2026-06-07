module sky130_fd_sc_hd__o32ai_1 (
    Y   ,
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

    output Y   ;
    input  A1  ;
    input  A2  ;
    input  A3  ;
    input  B1  ;
    input  B2  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // The sky130_fd_sc_hd__o32ai cell performs an OR-3 and AND-2 logic function with inversion.
    // Y = !((A1 | A2 | A3) & (B1 & B2))
    assign Y = ~((A1 | A2 | A3) & (B1 & B2));

endmodule
