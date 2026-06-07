// Definition of the base cell, addressing the black-box violation
module sky130_fd_sc_hd__o32ai (
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

    // Intermediate wires for logic calculation
    wire w_or3;
    wire w_or2;
    wire w_and_intermediate;

    // Logic for (A1 OR A2 OR A3)
    assign w_or3 = A1 | A2 | A3;

    // Logic for (B1 OR B2)
    assign w_or2 = B1 | B2;

    // Logic for ( (A1 OR A2 OR A3) AND (B1 OR B2) )
    assign w_and_intermediate = w_or3 & w_or2;

    // Inverted output: ! ( (A1 OR A2 OR A3) AND (B1 OR B2) )
    assign Y = ~w_and_intermediate;

endmodule
