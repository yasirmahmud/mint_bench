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

    // synthesis translate_off
    // W240: Dummy read for power/ground pins to satisfy linting rules.
    // These inputs (VPWR, VGND, VPB, VNB) are essential for the physical
    // cell connectivity but are not used in the behavioral logic of the DFF.
    // This 'initial' block is ignored by synthesis tools due to the pragmas.
    initial begin
        if ({VPWR, VGND, VPB, VNB} == 4'b0000) begin
            // This conditional is purely to ensure the inputs are 'read' by linting tools.
            // It has no functional effect on the synthesizable design.
        end
    end
    // synthesis translate_on

    always @(posedge CLK) begin
        if (SCE) begin
            Q_reg <= SCD;
        end else begin
            Q_reg <= D;
        end
    end

endmodule
