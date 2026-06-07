module curve_synth_5036_20260110_201305_attempt13 (
    input wire [7:0] in_a,
    input wire [7:0] in_b,
    input wire [7:0] in_c,
    input wire [7:0] in_d,
    output wire [7:0] out_val_1,
    output wire [7:0] out_val_2
);

    // Function 1: Triggers SYNTH_5036 by non-blocking assignment to its return value.
    // This construct signals that the non-blocking assignment will be treated as blocking for synthesis.
    function [7:0] calc_func_1 (input [7:0] operand_1, input [7:0] operand_2);
        calc_func_1 <= operand_1 & operand_2; // Violation 1 for SYNTH_5036
    endfunction

    // Function 2: Another instance to generate the second SYNTH_5036 violation.
    // This ensures exactly two occurrences of the target rule.
    function [7:0] calc_func_2 (input [7:0] operand_3, input [7:0] operand_4);
        calc_func_2 <= operand_3 | operand_4; // Violation 2 for SYNTH_5036
    endfunction

    // Instantiate the functions to ensure they are used and to provide outputs.
    assign out_val_1 = calc_func_1(in_a, in_b);
    assign out_val_2 = calc_func_2(in_c, in_d);

endmodule
