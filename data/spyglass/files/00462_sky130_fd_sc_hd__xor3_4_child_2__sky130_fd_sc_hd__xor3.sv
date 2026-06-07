module sky130_fd_sc_hd__xor3 (
    X   ,
    A   ,
    B   ,
    C   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Functional behavior: X = A ^ B ^ C
    assign X = A ^ B ^ C;

    // Dummy assignments to suppress W240 warnings for unused power/ground/body bias inputs.
    // These inputs are required for physical implementation but are not directly used in the RTL functional logic.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

endmodule
