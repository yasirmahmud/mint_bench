module curve_starc05_2_1_3_1_20260111_054323_attempt1 (
    input [3:0] in_arg_4bit,
    output [31:0] out_val
);

    // Function with a 32-bit input 'i'
    function [31:0] factorial;
        input [31:0] i; // Function input 'i' is 32 bits
        integer k;
        begin
            factorial = 1; // Initialize to 1 for factorial calculation
            for (k = 1; k <= i; k = k + 1) begin
                factorial = factorial * k;
            end
        end
    endfunction

    // Call the function 'factorial' with 'in_arg_4bit' (4 bits) as argument 'n'
    // This triggers STARC05-2.1.3.1 due to bit-width mismatch: 4-bit argument to 32-bit input
    // Fixed by explicitly zero-extending in_arg_4bit to 32 bits.
    assign out_val = factorial({28'd0, in_arg_4bit});

endmodule
