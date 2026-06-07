module sky130_fd_sc_hd__xnor2_1 (
    Y   ,
    A   ,
    B   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Behavioral definition for sky130_fd_sc_hd__xnor2 to resolve the "no definition" error.
    // This ensures the linter can find the design unit and understand its functionality
    // while preserving the port interface for power/ground connections.
