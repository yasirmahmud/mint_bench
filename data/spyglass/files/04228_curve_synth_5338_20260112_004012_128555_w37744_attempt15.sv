module curve_synth_5338_20260112_004012_128555_w37744_attempt15 (
    input [3:0] input_base_a,
    input [3:0] input_base_b,
    output [19:0] output_result_a,
    output [23:0] output_result_b
);

    // SYNTH_5338 violation 1:
    // Exponentiation is supported only if the base is a power of 2 or the exponent is 0, 1, or 2.
    // Here, 'input_base_a' is a 4-bit input, which is not guaranteed to be a power of 2.
    // The exponent '5' is not 0, 1, or 2.
    assign output_result_a = input_base_a ** 5;

    // SYNTH_5338 violation 2:
    // Exponentiation is supported only if the base is a power of 2 or the exponent is 0, 1, or 2.
    // Here, 'input_base_b' is a 4-bit input, which is not guaranteed to be a power of 2.
    // The exponent '6' is not 0, 1, or 2.
    assign output_result_b = input_base_b ** 6;

endmodule
