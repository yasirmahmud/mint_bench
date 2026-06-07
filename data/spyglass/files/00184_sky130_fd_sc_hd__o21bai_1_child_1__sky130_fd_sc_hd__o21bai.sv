// This module is a black box declaration for the underlying standard cell.
// It provides the interface definition to the linter, resolving the BBox error,
// without changing the functional behavior of the design which instantiates it.
module sky130_fd_sc_hd__o21bai (
    Y   ,
    A1  ,
    A2  ,
    B1_N,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output Y   ;
    input  A1  ;
    input  A2  ;
    input  B1_N;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    // No internal logic needed for linting, as this represents a standard cell.
endmodule
