module sky130_fd_sc_hd__sedfxbp (
    Q   ,
    Q_N ,
    CLK ,
    D   ,
    DE  ,
    SCD ,
    SCE ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Q   ;
    output Q_N ;
    input  CLK ;
    input  D   ;
    input  DE  ;
    input  SCD ;
    input  SCE ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    reg q_reg;

    always @(posedge CLK) begin
        if (SCE) begin
            q_reg <= SCD;
        end else if (DE) begin
            q_reg <= D;
        end
    end

    assign Q   = q_reg;
    assign Q_N = ~q_reg;

endmodule
