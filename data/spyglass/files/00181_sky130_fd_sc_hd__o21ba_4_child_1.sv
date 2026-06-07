module sky130_fd_sc_hd__o21ba (
    X   ,
    A1  ,
    A2  ,
    B1_N,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A1  ;
    input  A2  ;
    input  B1_N;
    input  VPWR; // Power and ground pins are typically inputs for standard cells
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Implement the logic described: X = (A1 OR A2) AND (NOT B1_N)
    assign X = (A1 | A2) & (~B1_N);

endmodule
