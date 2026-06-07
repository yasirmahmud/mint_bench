module curve_w218_20260111_224458_210521_w38092_attempt12 (
    input [1:0] multibit_sig,
    output reg dummy_out
);

    // W218 violation: Edge specification (posedge) should not be used
    // for a multibit expression ('multibit_sig' is 2 bits wide).
    // This attempt uses an 'initial' block with a 'wait' statement to trigger
    // the violation. This approach is intended to be purely for simulation/verification
    // and therefore should ideally avoid synthesis-related rules like SYNTH_5405
    // and ErrorAnalyzeBBox, which often accompany W218 when it appears in 'always' blocks.
    
    initial begin
        dummy_out = 1'b0; // Default value for dummy_out
        // The 'posedge' keyword used on a multibit signal 'multibit_sig'
        // within a 'wait' statement is the specific trigger for W218.
        wait (posedge multibit_sig); // Target line for W218
        $display("W218 triggered: Multibit edge detected on multibit_sig = %b at time %t", multibit_sig, $time);
        dummy_out = multibit_sig[0]; // Use multibit_sig and dummy_out to avoid unused warnings
    end

endmodule
