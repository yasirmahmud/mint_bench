module sky130_fd_sc_hd__or4b_2 (
    X   ,
    A   ,
    B   ,
    C   ,
    D_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  D_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Resolving 'ErrorAnalyzeBBox' by replacing the undefined black-box instantiation
    // with an equivalent behavioral assignment based on the design description.
    // The design description states: "logically ORs inputs A, B, and C with the inverted D_N signal"
    assign X = A | B | C | (~D_N);

endmodule
