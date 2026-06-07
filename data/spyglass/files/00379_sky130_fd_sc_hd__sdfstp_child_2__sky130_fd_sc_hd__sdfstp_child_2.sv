// The wrapper module, renamed to match the required filename `sky130_fd_sc_hd__sdfstp_child_2.v`.
// It instantiates the `sky130_fd_sc_hd__sdfstp` base cell, which is now defined above.
module sky130_fd_sc_hd__sdfstp_child_2 (
    Q    ,
    CLK  ,
    D    ,
    SCD  ,
    SCE  ,
    SET_B,
    VPWR ,
    VGND ,
    VPB  ,
    VNB
);

    output Q    ;
    input  CLK  ;
    input  D    ;
    input  SCD  ;
    input  SCE  ;
    input  SET_B;
    input  VPWR ;
    input  VGND ;
    input  VPB  ;
    input  VNB  ;

    sky130_fd_sc_hd__sdfstp base (
        .Q(Q),
        .CLK(CLK),
        .D(D),
        .SCD(SCD),
        .SCE(SCE),
        .SET_B(SET_B),
        .VPWR(VPWR),
        .VGND(VGND),
        .VPB(VPB),
        .VNB(VNB)
    );

endmodule
