// Definition for sky130_fd_sc_hd__sdlclkp to resolve the black-box violation
module sky130_fd_sc_hd__sdlclkp (
    GCLK,
    SCE ,
    GATE,
    CLK ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output GCLK;
    input  SCE ;
    input  GATE;
    input  CLK ;
    input  VPWR; // Power, typically not modeled behaviorally
    input  VGND; // Ground, typically not modeled behaviorally
    input  VPB ; // Power for bulk, typically not modeled behaviorally
    input  VNB ; // Ground for bulk, typically not modeled behaviorally

    // Behavioral model for a Scan-Delay-Lock Clock Gating cell (SDLCLKP)
    // The 'GATE' signal is latched, transparent when 'CLK' is low.
    // 'SCE' (Scan Enable) overrides the functional gate, forcing the clock 'ON' for scan.

    // Determine the effective input to the gate-enable latch.
    // If SCE is high, force the enable high (clock passes for scan).
    // Otherwise, use the functional GATE signal.
    wire effective_gate_input = SCE ? 1'b1 : GATE;

    // Internal latch to hold the effective gate enable signal
    reg latched_gate_enable;

    // Latch is transparent when CLK is low, and holds when CLK is high.
    always @(effective_gate_input or CLK) begin
        if (CLK == 1'b0) begin
            latched_gate_enable = effective_gate_input;
        end
        // When CLK is high, the latch holds its current value (latched_gate_enable remains unchanged).
    end

    // Gated clock output: follows CLK only when the latched enable is high.
    assign GCLK = CLK && latched_gate_enable;

endmodule
