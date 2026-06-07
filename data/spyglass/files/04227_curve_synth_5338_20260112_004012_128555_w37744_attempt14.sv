module curve_synth_5338_20260112_004012_128555_w37744_attempt14 (
    input [3:0] base_val,
    output [15:0] result
);

    // SYNTH_5338 violation: Exponentiation is supported only if the base is a power of 2
    // or the exponent is 0, 1, or 2.
    // Here, 'base_val' is an input, so it's not guaranteed to be a power of 2.
    // The exponent '4' is not 0, 1, or 2.
    assign result = base_val ** 4;

endmodule
