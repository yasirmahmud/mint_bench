module curve_synth_5036_20260112_003533_354997_w25608_attempt16 (
    input [7:0] operand_a,
    input [7:0] operand_b,
    output [7:0] result_or
);

    // This function demonstrates the SYNTH_5036 violation.
    // A non-blocking assignment ('<=') to the function's return value
    // inside a function will be treated as blocking for synthesis.
    function [7:0] calculate_bitwise_or (input [7:0] val_a, input [7:0] val_b);
        calculate_bitwise_or <= val_a | val_b; // SYNTH_5036 violation
    endfunction

    // Instantiate the function to ensure its usage and avoid WRN_44 (unused signal) violations.
    assign result_or = calculate_bitwise_or(operand_a, operand_b);

endmodule
