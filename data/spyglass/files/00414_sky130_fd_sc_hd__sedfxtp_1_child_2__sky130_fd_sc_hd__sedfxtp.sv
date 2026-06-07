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
    supply1 VPWR; // Declare power nets as supply to indicate their usage and resolve W240
    supply0 VGND;
    supply1 VPB;
    supply0 VNB;

    reg Q_reg; // Internal register to hold the state

    assign Q = Q_reg;

    // Behavioral model for a scan-enabled DFF with data enable
    // SCE (Scan Enable) takes precedence over DE (Data Enable)
    always @(posedge CLK) begin
        if (SCE) begin
            Q_reg <= SCD; // Capture Scan Data
        end else if (DE) begin
            Q_reg <= D;   // Capture Data when Data Enable is active
        end
        // If neither SCE nor DE is active, the flip-flop holds its current value (Q_reg remains unchanged).
    end

endmodule
