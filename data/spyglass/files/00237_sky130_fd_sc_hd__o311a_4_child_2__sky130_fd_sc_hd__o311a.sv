module sky130_fd_sc_hd__o311a (
    X   ,
    A1  ,
    A2  ,
    A3  ,
    B1  ,
    C1  ,
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
    input  C1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // This is a stub module to resolve the SpyGlass 'WarnAnalyzeBBox' and 'W240' violations.
    // The actual functional behavior of this cell is defined in the technology library.
    // For linting purposes, a minimal functional model is provided to ensure all logical inputs are 'read' and the output is 'driven'.
    assign X = (A1 | A2 | A3) & B1 & C1;

    // Power pins VPWR, VGND, VPB, VNB are typically connected but not functionally 'read' by logic.
    // Dummy assignments are added to resolve 'W240: Input declared but not read' warnings for these pins,
    // without altering the logical behavior of the gate, as the true function is defined externally.
    wire _dummy_VPWR = VPWR;
    wire _dummy_VGND = VGND;
    wire _dummy_VPB  = VPB;
    wire _dummy_VNB  = VNB;

endmodule
