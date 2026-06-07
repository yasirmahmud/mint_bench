module sky130_fd_sc_hd__sedfxtp (
    Q   ,
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
    input  CLK ;
    input  D   ;
    input  DE  ;
    input  SCD ;
    input  SCE ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    reg Q_reg; // Internal register to hold the state

    // Assign output Q to the internal register
    assign Q = Q_reg;

    always @(posedge CLK) begin
        if (SCE) begin
            Q_reg <= SCD; // Scan mode: capture scan data
        end else if (DE) begin
            Q_reg <= D;   // Normal mode, data enabled: capture D
        end
        // Else (SCE = 0, DE = 0): Q_reg holds its previous value
    end

endmodule
