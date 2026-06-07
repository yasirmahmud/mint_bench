module sky130_fd_sc_hd__o221a (
    X   ,
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
    output X;
    input  A1;
    input  A2;
    input  B1;
    input  B2;
    input  C1;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Define the logical behavior of the o221a cell
    // A common interpretation for o221a is X = (A1 | A2) | (B1 & B2) | C1
    assign X = (A1 | A2) | (B1 & B2) | C1;

endmodule
