module sky130_fd_sc_hd__o21a (
    X   ,
    A1  ,
    A2  ,
    B1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A1  ;
    input  A2  ;
    input  B1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Implement the O21A logic: X = B1 | (A1 & A2)
    assign X = B1 | (A1 & A2);

endmodule
