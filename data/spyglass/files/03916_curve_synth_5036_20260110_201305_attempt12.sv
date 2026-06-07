module curve_synth_5036_20260110_201305_attempt12 (
    input wire [7:0] in1,
    input wire [7:0] in2,
    input wire [7:0] in3,
    input wire [7:0] in4,
    output wire [7:0] out1,
    output wire [7:0] out2
);

    // Function 1: Triggers SYNTH_5036 for non-blocking assignment to its return value.
    // SpyGlass will treat the non-blocking assignment to 'my_sum_function' as blocking
    // during synthesis, leading to a SYNTH_5036 violation.
    function [7:0] my_sum_function (input [7:0] val_a, input [7:0] val_b);
        my_sum_function <= val_a + val_b; // Violation 1 for SYNTH_5036
    endfunction

    // Function 2: Another instance to generate the second SYNTH_5036 violation.
    // This ensures exactly two occurrences of the rule.
    function [7:0] my_diff_function (input [7:0] val_c, input [7:0] val_d);
        my_diff_function <= val_c - val_d; // Violation 2 for SYNTH_5036
    endfunction

    // Instantiate the functions to ensure they are used and to provide outputs.
    assign out1 = my_sum_function(in1, in2);
    assign out2 = my_diff_function(in3, in4);

endmodule
