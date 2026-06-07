// Definition of the base XOR2 module to resolve the black-box violation
module sky130_fd_sc_hd__xor2 (
    X   ,
    A   ,
    B   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output X   ;
    input  A   ;
    input  B   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Implement XOR logic
    assign X = A ^ B;

endmodule
