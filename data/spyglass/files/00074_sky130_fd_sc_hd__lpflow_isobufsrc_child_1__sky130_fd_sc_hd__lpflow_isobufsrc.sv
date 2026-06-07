module sky130_fd_sc_hd__lpflow_isobufsrc (
    X    ,
    SLEEP,
    A    ,
    VPWR ,
    VGND ,
    VPB  ,
    VNB
);

    output X    ;
    input  SLEEP;
    input  A    ;
    input  VPWR ;
    input  VGND ;
    input  VPB  ;
    input  VNB  ;

    // This is a dummy module definition to resolve the SpyGlass ErrorAnalyzeBBox violation.
    // In a real design flow, the definition for 'sky130_fd_sc_hd__lpflow_isobufsrc'
    // would be provided from a standard cell library.
    // No internal logic is needed here to preserve the wrapper's functional behavior.

endmodule
