module curve_synth_5058_20260112_010456_429467_w37744_attempt14 (
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    output wire       match_out
);

    // Each of these 'assign' statements uses the Verilog case equality operator (===),
    // which performs a bit-for-bit comparison, including 'X' and 'Z' states.
    // Synthesis tools, however, typically cannot preserve this behavior for 'X' and 'Z'
    // and will instead treat it as a standard logical equality (==).
    // This translation by the synthesis tool is what triggers the SYNTH_5058 warning.

    // Occurrence 1: Compare an input signal against a fully-defined constant.
    wire match_const1 = (data_in_a === 8'hAA);

    // Occurrence 2: Compare another input signal against a different fully-defined constant.
    wire match_const2 = (data_in_b === 8'h55);

    // Occurrence 3: Compare two input signals against each other.
    wire match_inputs = (data_in_a === data_in_b);

    // Occurrence 4: Compare an input signal against a constant containing an 'X' bit.
    // This explicitly demonstrates the scenario where the strict equality behavior
    // for 'X' states cannot be maintained by synthesis.
    wire match_x_val  = (data_in_a === 8'b1010_101x);

    // Combine all comparison results to ensure all intermediate wires are used
    // and contribute to a top-level output, preventing unused signal warnings.
    assign match_out = match_const1 || match_const2 || match_inputs || match_x_val;

endmodule
