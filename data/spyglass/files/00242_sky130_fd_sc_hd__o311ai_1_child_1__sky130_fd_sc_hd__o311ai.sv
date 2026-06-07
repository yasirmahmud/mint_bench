// Definition for the instantiated black-box cell.
// This module declaration provides the necessary interface for linting tools
// and treats the cell as a black box, preserving its intended functional behavior
// as an external standard cell.
module sky130_fd_sc_hd__o311ai (
    Y,
    A1,
    A2,
    A3,
    B1,
    C1,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A1;
    input  A2;
    input  A3;
    input  B1;
    input  C1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;
    // No internal logic is provided here as this is a standard cell whose
    // functional behavior is defined in the technology library.
endmodule
