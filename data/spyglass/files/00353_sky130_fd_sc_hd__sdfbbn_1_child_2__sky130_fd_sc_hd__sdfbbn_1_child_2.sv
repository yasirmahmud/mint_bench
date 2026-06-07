module sky130_fd_sc_hd__sdfbbn_1_child_2 (
    Q      ,
    Q_N    ,
    D      ,
    SCD    ,
    SCE    ,
    CLK_N  ,
    SET_B  ,
    RESET_B,
    VPWR   ,
    VGND   ,
    VPB    ,
    VNB
);

    output Q      ;
    output Q_N    ;
    input  D      ;
    input  SCD    ;
    input  SCE    ;
    input  CLK_N  ;
    input  SET_B  ;
    input  RESET_B;
    input  VPWR   ;
    input  VGND   ;
    input  VPB    ;
    input  VNB    ;

    // According to the design description, "This module wraps an underlying scan-enabled flip-flop cell
    // with an inverted clock, data, scan, set, and reset inputs".
    // - CLK_N, SET_B, RESET_B are already named to indicate inverted/active-low and are passed directly.
    // - D and SCD are specified as "inverted data" inputs to this wrapper module,
    //   so they need to be inverted back before being passed to the underlying cell which expects active-high data.
    wire D_active_high;
    wire SCD_active_high;

    assign D_active_high = ~D;
    assign SCD_active_high = ~SCD;

    sky130_fd_sc_hd__sdfbbn base (
        .Q(Q),
        .Q_N(Q_N),
        .D(D_active_high),       // Invert wrapper's D input for base cell
        .SCD(SCD_active_high),   // Invert wrapper's SCD input for base cell
        .SCE(SCE),
        .CLK_N(CLK_N),
        .SET_B(SET_B),
        .RESET_B(RESET_B),
        .VPWR(VPWR),
        .VGND(VGND),
        .VPB(VPB),
        .VNB(VNB)
    );

endmodule
