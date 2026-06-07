module curve_synth_5036_20260112_003533_354997_w25608_attempt18 (
    input [7:0] data_in_a,
    input [7:0] data_in_b,
    input [2:0] clear_bit_pos,
    output [7:0] result_a,
    output [7:0] result_b
);

    // Function 1: Computes the bitwise one's complement of the input.
    // The non-blocking assignment to the function's return value inside
    // this function will be treated as blocking during synthesis, thereby
    // triggering the SYNTH_5036 violation for the first occurrence.
    function [7:0] compute_complement (input [7:0] value_in);
        compute_complement <= ~value_in; // Violation 1 for SYNTH_5036
    endfunction

    // Function 2: Clears a specific bit at 'clear_bit_pos' in the input value.
    // This also uses a non-blocking assignment to its return value, leading
    // to a second SYNTH_5036 violation as it will be treated as blocking
    // during synthesis.
    function [7:0] clear_specific_bit (input [7:0] value_in, input [2:0] bit_pos);
        clear_specific_bit <= value_in & ~(8'b1 << bit_pos); // Violation 2 for SYNTH_5036
    endfunction

    // Assign module outputs to the results of the functions to ensure they are
    // instantiated and to avoid unused signal warnings.
    assign result_a = compute_complement(data_in_a);
    assign result_b = clear_specific_bit(data_in_b, clear_bit_pos);

endmodule
