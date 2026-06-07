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
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Dummy assignments to resolve 'input declared but not read' warnings (W240)
    // for power and ground pins. These assignments do not affect the functional logic of X,
    // but ensure the linter sees these inputs as 'read'.
    wire _unused_VPWR;
    wire _unused_VGND;
    wire _unused_VPB;
    wire _unused_VNB;

    assign _unused_VPWR = VPWR;
    assign _unused_VGND = VGND;
    assign _unused_VPB  = VPB;
    assign _unused_VNB  = VNB;

    // Implement the logic described: X = (A1 OR A2) AND (NOT B1_N)
    assign X = (A1 | A2) & (~B1_N);

endmodule
