// Definition for the black-boxed standard cell to resolve SpyGlass ErrorAnalyzeBBox
module sky130_fd_sc_hd__o41ai (
    Y   ,
    A1  ,
    A2  ,
    A3  ,
    A4  ,
    B1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output Y;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  B1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // O41AI gate behavior: Y = ~((A1 | A2 | A3 | A4) | B1)
    assign Y = ~((A1 | A2 | A3 | A4) | B1);

endmodule
