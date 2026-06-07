module curve_synth_5284_20260110_202743_attempt8 (
    output reg dummy_out
);

    // SYNTH_5284: Non synthesizable construct : floating point type constant.
    // Declaring and initializing 'real' variables with floating point constants
    // is a non-synthesizable construct, triggering the target rule for each instance.
    real float_val_1 = 1.0; // Occurrence 1
    real float_val_2 = 2.5; // Occurrence 2

    // Drive an output to avoid potential unused output port warnings.
    // This construct itself is synthesizable and should not trigger other rules.
    always @(*) begin
        dummy_out = 1'b0;
    end

endmodule
