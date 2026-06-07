module sky130_fd_sc_hd__sdfstp_4 (
    Q    ,
    CLK  ,
    D    ,
    SCD  ,
    SCE  ,
    SET_B
);

    output Q    ;
    input  CLK  ;
    input  D    ;
    input  SCD  ;
    input  SCE  ;
    input  SET_B;

    sky130_fd_sc_hd__sdfstp base (
        .Q(Q),
        .CLK(CLK),
        .D(D),
        .SCD(SCD),
        .SCE(SCE),
        .SET_B(SET_B)
    );

endmodule
