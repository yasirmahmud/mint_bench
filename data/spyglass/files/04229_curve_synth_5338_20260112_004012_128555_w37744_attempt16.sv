module curve_synth_5338_20260112_004012_128555_w37744_attempt16 (
    input [3:0] input_base,
    output [15:0] output_result
);

    // SYNTH_5338 violation: Exponentiation is supported only if the base is a power of 2
    // or the exponent is 0, 1, or 2.
    // Here, 'input_base' is a 4-bit input, which is not guaranteed to be a power of 2.
    // The exponent '4' is not 0, 1, or 2, therefore triggering the violation.
    assign output_result = input_base ** 4;

endmodule
