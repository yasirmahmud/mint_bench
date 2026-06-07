module curve_synth_5058_20260112_010456_429467_w37744_attempt15 (
    input wire [3:0] in_a,
    input wire [3:0] in_b,
    input wire [3:0] in_c,
    input wire [3:0] in_d,
    output wire out_match_all
);

    // SYNTH_5058: Operator (===) encountered. Treating as (==) for synthesis
    // This rule is triggered when the case equality operator (===) is used in synthesizable code.
    // Synthesis tools typically cannot preserve the strict 'X' and 'Z' handling of '==='
    // and will instead treat it as a standard logical equality (==).

    // Occurrence 1: Compare two input signals.
    wire match_a_b = (in_a === in_b);

    // Occurrence 2: Compare another two input signals.
    wire match_c_d = (in_c === in_d);

    // Occurrence 3: Compare an input signal against a fully-defined constant.
    wire match_a_const = (in_a === 4'b1010);

    // Occurrence 4: Compare another input signal against a different fully-defined constant.
    wire match_b_const = (in_b === 4'b0101);

    // Combine all intermediate wires into a single output to prevent unused signal warnings.
    assign out_match_all = match_a_b && match_c_d && match_a_const && match_b_const;

endmodule
