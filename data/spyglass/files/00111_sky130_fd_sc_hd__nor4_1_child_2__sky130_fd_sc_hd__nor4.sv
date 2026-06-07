// Definition for the base NOR4 cell, previously a black-box
module sky130_fd_sc_hd__nor4 (
    Y   ,
    A   ,
    B   ,
    C   ,
    D
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  D   ;

    // Implement the NOR4 logic
    assign Y = ~(A | B | C | D);

endmodule
