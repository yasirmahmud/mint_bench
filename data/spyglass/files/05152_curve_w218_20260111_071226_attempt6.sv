module curve_w218_20260111_071226_attempt6 (
    input [1:0] multibit_sig, // Multibit signal to trigger W218
    input       enable_in,
    output reg  output_data
);

    // W218 trigger: Edge specification should not be used for a multibit expression.
    // This 'always' block uses 'posedge' on a multibit signal 'multibit_sig'.
    // By containing only non-synthesizable code ($display), we aim to prevent
    // a potential SYNTH_5405 violation (Multibit signal used as a clock),
    // as synthesis tools might ignore this block for clocking analysis.
    // However, W218, being a more fundamental semantic/design rule check,
    // should still be triggered by the use of 'posedge' on a multibit expression.
    always @(posedge multibit_sig) begin // This line targets W218
        $display("W218 trigger: Multibit edge detected on multibit_sig = %b", multibit_sig);
    end

    // A minimal synthesizable block to ensure the module is considered by synthesis tools
    // and to avoid other general synthesis errors (e.g., ErrorAnalyzeBBox for unsynthesizable DU).
    // This block is designed not to cause any additional violations.
    always @(*) begin
        output_data = enable_in; // Simple combinational assignment
    end

endmodule
