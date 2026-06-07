module curve_starc05_2_1_3_1_20260111_224108_074773_w28836_attempt11 (
    input [2:0] data_in,      // 3 bits
    output [5:0] result_out  // 6 bits for the output of the 6-bit function
);

    // Define a function that expects a 6-bit input
    function [5:0] calculate_sum_6bit;
        input [5:0] op_param_6bit; // Function input expects 6 bits
        begin
            calculate_sum_6bit = op_param_6bit + 3'h3;
        end
    endfunction

    // The function input 'op_param_6bit' expects 6 bits.
    // Calling it with 'data_in' (3 bits) creates a bit-width mismatch (3 bits vs 6 bits).
    // This triggers STARC05-2.1.3.1.
    assign result_out = calculate_sum_6bit(data_in);

endmodule
