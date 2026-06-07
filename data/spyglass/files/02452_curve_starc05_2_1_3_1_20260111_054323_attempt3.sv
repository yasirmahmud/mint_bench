module curve_starc05_2_1_3_1_20260111_054323_attempt3 (
    input [15:0] data_in,      // Argument to be passed (16 bits)
    output [63:0] result_out
);

    // Function with a 64-bit input 'operand'
    function [63:0] process_data;
        input [63:0] operand; // Function input (64 bits)
        begin
            process_data = operand + 1;
        end
    endfunction

    // Call the function 'process_data' with 'data_in' (16 bits) as argument
    // This triggers STARC05-2.1.3.1 due to bit-width mismatch:
    // 16-bit argument 'data_in' passed to 64-bit function input 'operand'.
    assign result_out = process_data(data_in);

endmodule
