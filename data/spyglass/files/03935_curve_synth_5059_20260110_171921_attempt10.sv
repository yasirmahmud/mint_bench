module curve_synth_5059_20260110_171921_attempt10 (
    input [7:0] data_in_a,
    input [7:0] data_in_b,
    output wire result_out
);

// Target rule: SYNTH_5059 - Case inequality (!==) encountered which is not supported by synthesis. Replace with (!=)
// This module uses the '!==` operator in a continuous assignment to trigger the rule.
// It compares two multi-bit input signals, avoiding 'x' or 'z' literals.

assign result_out = (data_in_a !== data_in_b);

endmodule
