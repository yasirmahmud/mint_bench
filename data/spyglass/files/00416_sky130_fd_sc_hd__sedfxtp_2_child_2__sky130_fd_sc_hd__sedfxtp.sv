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

    // Dummy assignments to suppress W240 warnings for unused power/ground/bulk inputs
    // These inputs are for physical design and power integrity and do not directly affect functional behavior in this behavioral model.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

    always @(posedge CLK) begin
        if (SCE) begin
            Q_reg <= SCD;
        end else if (DE) begin
            Q_reg <= D;
        end
    end

    assign Q = Q_reg;

endmodule
