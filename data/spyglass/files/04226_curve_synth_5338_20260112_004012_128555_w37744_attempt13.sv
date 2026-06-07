module curve_synth_5338_20260112_004012_128555_w37744_attempt13 (
    input [3:0] base_in,
    output [11:0] result_exp3,
    output [19:0] result_exp5
);

    // SYNTH_5338 violation 1: The base 'base_in' is an input and not guaranteed to be a power of 2.
    // The exponent '3' is not 0, 1, or 2.
    assign result_exp3 = base_in ** 3;

    // SYNTH_5338 violation 2: The base 'base_in' is an input and not guaranteed to be a power of 2.
    // The exponent '5' is not 0, 1, or 2.
    assign result_exp5 = base_in ** 5;

endmodule
