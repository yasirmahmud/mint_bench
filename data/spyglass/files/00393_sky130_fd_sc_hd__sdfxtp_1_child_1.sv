module sky130_fd_sc_hd__sdfxtp_1 (
    output Q,
    input  CLK,
    input  D,
    input  SCD,
    input  SCE,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);

    reg Q_reg;

    assign Q = Q_reg;

    always @(posedge CLK) begin
        if (SCE) begin
            Q_reg <= SCD;
        end else begin
            Q_reg <= D;
        end
    end

endmodule
