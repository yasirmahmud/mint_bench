// This is a black-box definition for the 'sky130_fd_sc_hd__o211ai' cell.
// It is added to resolve SpyGlass 'ErrorAnalyzeBBox' violations when the actual cell definition
// is not present in the linting environment. It preserves the interface of the cell.
module sky130_fd_sc_hd__o211ai (
    Y   ,
    A1  ,
    A2  ,
    B1  ,
    C1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Y   ;
    input  A1  ;
    input  A2  ;
    input  B1  ;
    input  C1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // No internal logic, as this is a black-box definition

endmodule
