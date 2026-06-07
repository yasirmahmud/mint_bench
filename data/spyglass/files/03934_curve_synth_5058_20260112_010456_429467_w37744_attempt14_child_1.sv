module curve_synth_5058_20260112_010456_429467_w37744_attempt14 (
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    output wire       match_out
);

    // Each of these 'assign' statements originally used the Verilog case equality operator (===),
    // which performs a bit-for-bit comparison, including 'X' and 'Z' states.
    // As described, synthesis tools typically cannot preserve this behavior for 'X' and 'Z'
    // and will instead treat it as a standard logical equality (==). This translation by the
    // synthesis tool is what triggers the SYNTH_5058 and W339a warnings, and the STARC05-2.10.1.4b
    // error (for comparing with 'X' bits).
    //
    // To resolve these linting violations while preserving the functional behavior as it would
    // be interpreted by synthesis tools, the case equality operator (===) has been replaced
    // with the logical equality operator (==) in all occurrences.
    // This change explicitly codifies the behavior that synthesis tools implicitly implement,
    // thereby eliminating the warnings related to ambiguous X/Z handling in synthesis.

    // Occurrence 1: Compare an input signal against a fully-defined constant.
    wire match_const1 = (data_in_a == 8'hAA);

    // Occurrence 2: Compare another input signal against a different fully-defined constant.
    wire match_const2 = (data_in_b == 8'h55);

    // Occurrence 3: Compare two input signals against each other.
    wire match_inputs = (data_in_a == data_in_b);

    // Occurrence 4: Compare an input signal against a constant containing an 'X' bit.
    // The comparison now uses '==', aligning with how synthesis tools interpret '==='
    // in such scenarios, which results in X propagation for unknown bits.
    wire match_x_val  = (data_in_a == 8'b1010_101x);

    // Combine all comparison results to ensure all intermediate wires are used
    // and contribute to a top-level output, preventing unused signal warnings.
    assign match_out = match_const1 || match_const2 || match_inputs || match_x_val;

endmodule
