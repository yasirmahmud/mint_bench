module sky130_fd_sc_hd__sdfxbp (
    Q,
    Q_N,
    CLK,
    D,
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
    input SCD;
    input SCE;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    reg q_reg;

    always @(posedge CLK) begin
        if (SCE) begin
            q_reg <= SCD;
        end else begin
            q_reg <= D;
        end
    end

    assign Q = q_reg;
    assign Q_N = ~q_reg;

    // Resolve 'Input declared but not read' warnings for power/ground pins
    // These are typically implicitly used by the cell's physical implementation.
    // Adding dummy assignments to explicitly 'read' them for linting.
    wire _unused_vpwr = VPWR;
    wire _unused_vgnd = VGND;
    wire _unused_vpb = VPB;
    wire _unused_vnb = VNB;

endmodule
