module curve_starc05_2_1_3_1_20260111_224108_074773_w28836_attempt12 (
    input [3:0] input_data,      // 4 bits
    output [7:0] calculated_value // 8 bits for the output of the 8-bit function
);

    // Define a function that expects an 8-bit input
    function [7:0] process_data_8bit;
        input [7:0] fn_param_8bit; // Function input expects 8 bits
        begin
            process_data_8bit = fn_param_8bit + 8'hA; // Simple arithmetic to use the input
        end
    endfunction

    // The function input 'fn_param_8bit' expects 8 bits.
    // Calling it with 'input_data' (4 bits) creates a bit-width mismatch (4 bits vs 8 bits).
    // This triggers STARC05-2.1.3.1.
    assign calculated_value = process_data_8bit(input_data);

endmodule
