module curve_synth_5036_20260112_003533_354997_w25608_attempt19 (
    input [7:0] input_data_a,
    input [7:0] input_data_b,
    input [7:0] input_data_c,
    input [7:0] input_data_d,
    output result_gt,
    output result_eq
);

    // Function 1: Checks if input_a is greater than input_b.
    // The non-blocking assignment to the function's return value
    // (is_greater <= ...) will be treated as blocking during synthesis,
    // thereby triggering the SYNTH_5036 violation for the first occurrence.
    function is_greater (input [7:0] val_a, input [7:0] val_b);
        is_greater <= (val_a > val_b); // Violation 1 for SYNTH_5036
    endfunction

    // Function 2: Checks if input_c is equal to input_d.
    // This also uses a non-blocking assignment to its return value,
    // leading to a second SYNTH_5036 violation as it will be treated
    // as blocking during synthesis.
    function is_equal_to (input [7:0] val_c, input [7:0] val_d);
        is_equal_to <= (val_c == val_d); // Violation 2 for SYNTH_5036
    endfunction

    // Assign module outputs to the results of the functions to ensure they are
    // instantiated and used, thereby avoiding unused signal warnings.
    assign result_gt = is_greater(input_data_a, input_data_b);
    assign result_eq = is_equal_to(input_data_c, input_data_d);

endmodule
