module sky130_fd_sc_hd__o31a (
    X   ,
    A1  ,
    A2  ,
    A3  ,
    B1  ,
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
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Functional behavior: ORs three inputs and then ANDs the result with a fourth input
    assign X = (A1 | A2 | A3) & B1;

endmodule
