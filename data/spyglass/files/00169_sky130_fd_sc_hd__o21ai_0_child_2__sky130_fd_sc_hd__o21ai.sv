module sky130_fd_sc_hd__o21ai (
    Y   ,
    A1  ,
    A2  ,
    B1
);

    output Y   ;
    input  A1  ;
    input  A2  ;
    input  B1  ;

    // Functional behavior: inverts the output of an AND between B1 and the OR of A1 and A2.
    assign Y = ~ (B1 & (A1 | A2));

endmodule
