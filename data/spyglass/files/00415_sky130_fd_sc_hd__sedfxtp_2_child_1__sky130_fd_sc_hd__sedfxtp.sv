module sky130_fd_sc_hd__sedfxtp (
    output Q,
    input CLK,
    input D,
    input DE,
    input SCD,
    input SCE,
    input VPWR,
    input VGND,
    input VPB,
    input VNB
);

    reg Q_reg;

    always @(posedge CLK) begin
        if (SCE) begin
            Q_reg <= SCD;
        end else if (DE) begin
            Q_reg <= D;
        end
    end

    assign Q = Q_reg;

endmodule
