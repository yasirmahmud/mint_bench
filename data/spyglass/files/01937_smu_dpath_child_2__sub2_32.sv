// Behavioral model for 32-bit subtractor
// und_flw_bit indicates if operand1 < operand2 (unsigned underflow).
module sub2_32 (output [31:0] result,
                output und_flw_bit,
                input [31:0] operand1, operand2);
    assign result = operand1 - operand2;
    assign und_flw_bit = (operand1 < operand2); // Indicates unsigned underflow
endmodule
