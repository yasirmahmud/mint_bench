module curve_synth_5036_20260112_003533_354997_w25608_attempt17 (
    input [7:0] data_in_a,
    input [7:0] data_in_b,
    output [7:0] result_a,
    output [7:0] result_b
);

    // Function to increment a value. The non-blocking assignment inside this function
    // will be treated as blocking for synthesis, triggering SYNTH_5036.
    function [7:0] increment_value (input [7:0] value);
        increment_value <= value + 8'd1; // Violation 1 for SYNTH_5036
    endfunction

    // Another function to decrement a value. This also uses a non-blocking assignment
    // to its return value, triggering a second SYNTH_5036 violation.
    function [7:0] decrement_value (input [7:0] value);
        decrement_value <= value - 8'd1; // Violation 2 for SYNTH_5036
    endfunction

    // Assign outputs to ensure functions are used and avoid unused signal warnings.
    assign result_a = increment_value(data_in_a);
    assign result_b = decrement_value(data_in_b);

endmodule
