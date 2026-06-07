module curve_starc05_2_1_3_1_20260111_054323_attempt2 (
    input [3:0] n,             // Argument 'n' (4 bits)
    output [31:0] out_val
);

    // Function with a 32-bit input 'i'
    function [31:0] my_operation;
        input [31:0] i;    // Function input 'i' (32 bits)
        begin
            my_operation = i + 1;
        end
    endfunction

    // Call the function 'my_operation' with 'n' (4 bits) as argument
    // This triggers STARC05-2.1.3.1 due to bit-width mismatch:
    // 4-bit argument 'n' passed to 32-bit function input 'i'.
    assign out_val = my_operation(n);

endmodule
