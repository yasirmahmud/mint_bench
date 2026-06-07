// Definition for the base cell 'sky130_fd_sc_hd__sdlclkp' to resolve the ErrorAnalyzeBBox violation.
// This acts as a black-box declaration since its internal logic is not provided.
module sky130_fd_sc_hd__sdlclkp (
    GCLK,
    SCE ,
    GATE,
    CLK ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output GCLK;
    input  SCE ;
    input  GATE;
    input  CLK ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    // No internal logic, as its definition is external to this file
    // and we are simply providing an interface definition for linting.
endmodule
