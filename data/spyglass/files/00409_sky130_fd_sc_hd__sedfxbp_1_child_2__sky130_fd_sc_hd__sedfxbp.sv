module sky130_fd_sc_hd__sedfxbp (
    Q,
    Q_N,
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
    output Q_N;
    input CLK;
    input D;
    input DE;
    input SCD;
    input SCE;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    reg Q_reg; // Internal register for Q

    // Drive outputs from the internal register
    assign Q = Q_reg;
    assign Q_N = ~Q_reg; // Inverted output

    // Sequential logic for the scan-enabled D flip-flop with enable
    always @(posedge CLK) begin
        if (SCE) begin
            Q_reg <= SCD; // Scan mode: capture scan data
        end else if (DE) begin
            Q_reg <= D;   // Normal mode with enable: capture data
        end
        // If neither SCE nor DE is active (both low), Q_reg holds its current value.
        // This behavior is implied by the 'if-else if' structure for a DFF.
    end

    // Dummy assignments to satisfy "declared but not read" warnings for power/ground inputs.
    // These inputs are typically physical connections in standard cells, not logical signals,
    // but linters may flag them as unused if not mentioned in the functional description.
    wire _VPWR_dummy_ = VPWR;
    wire _VGND_dummy_ = VGND;
    wire _VPB_dummy_  = VPB;
    wire _VNB_dummy_  = VNB;

endmodule
