module sky130_fd_sc_hd__sdfstp (
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

    reg Q_reg;

    assign Q = Q_reg;

    always @(posedge CLK or negedge SET_B) begin
        if (!SET_B) begin // Asynchronous active-low set
            Q_reg <= 1'b1;
        end else begin
            if (SCE) begin // Scan mode
                Q_reg <= SCD;
            end else begin // Functional mode
                Q_reg <= D;
            end
        end
    end

endmodule
