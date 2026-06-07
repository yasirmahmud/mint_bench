// Wrapper module sky130_fd_sc_hd__sdfrtp_1
// This module acts as a direct wrapper for the sky130_fd_sc_hd__sdfrtp cell.
module sky130_fd_sc_hd__sdfrtp_1 (
    Q      ,
    CLK    ,
    D      ,
    SCD    ,
    SCE    ,
    RESET_B,
    VPWR   ,
    VGND   ,
    VPB    ,
    VNB
);

    output Q      ;
    input  CLK    ;
    input  D      ;
    input  SCD    ;
    input  SCE    ;
    input  RESET_B;
    input  VPWR   ;
    input  VGND   ;
    input  VPB    ;
    input  VNB    ;

    // Instantiate the base flip-flop cell
    sky130_fd_sc_hd__sdfrtp base (
        .Q(Q),
        .CLK(CLK),
        .D(D),
        .SCD(SCD),
        .SCE(SCE),
        .RESET_B(RESET_B),
        .VPWR(VPWR),
        .VGND(VGND),
        .VPB(VPB),
        .VNB(VNB)
    );

endmodule
