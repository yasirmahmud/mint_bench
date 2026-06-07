// Stub definition for sky130_fd_sc_hd__sedfxtp to resolve WarnAnalyzeBBox and W240 warnings
// This provides a module header and basic functional behavior so the linter can find the definition of the instantiated cell and verify port usage.
module sky130_fd_sc_hd__sedfxtp (
    Q,
    CLK,
    D,
    DE,
    SCD,
    SCE,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Q;
    input CLK;
    input D;
    input DE;
    input SCD;
    input SCE;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    reg Q_reg;

    // Sequential logic for a scan-enabled D-flip-flop
    // Q is updated on the positive edge of CLK, if DE is active.
    // If SCE is active, scan data (SCD) is loaded; otherwise, functional data (D) is loaded.
    always @(posedge CLK) begin
        if (DE) begin // Data Enable
            if (SCE) begin // Scan Enable is active, use scan data
                Q_reg <= SCD;
            end else begin // Scan Enable is inactive, use functional data
                Q_reg <= D;
            end
        end
    end

    assign Q = Q_reg;

endmodule
