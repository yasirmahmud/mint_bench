module divide(dividend, divisor, quotient, remainder);
    input [3:0] dividend, divisor;
    output reg [3:0] quotient, remainder;

    // Declare temporary variables and loop variable at module level
    // as required by standard Verilog-2001 for proper scoping
    // and to avoid 'Syntax error near (;)' and 'Identifier not declared' violations.
    reg [3:0] temp_quotient;
    reg [3:0] temp_remainder;
    integer i; // Loop variable for fixed iterations

    always @* begin
        // Initialize temporary variables for the calculation, mirroring the original behavior
        temp_quotient = 0;
        temp_remainder = dividend;

        // The original design uses a 'while' loop which can be problematic for synthesis
        // due to its variable number of iterations, especially when the maximum limit
        // is not explicitly bounded or exceeds default synthesis tool limits (SYNTH_5230).
        // For 4-bit numbers, the maximum number of subtractions (when dividend=15, divisor=1)
        // is 15. A 'for' loop iterating a fixed, sufficient number of times (e.g., 16 iterations)
        // can replace the 'while' loop, allowing the synthesizer to unroll it into combinational logic.
        for (i = 0; i < 16; i = i + 1) begin
            // The subtraction and increment only occur if the condition of the original 'while' loop is met.
            // An explicit check for 'divisor != 0' is added to prevent an infinite loop in simulation
            // and to provide a synthesizable behavior in the case of division by zero.
            // If divisor is zero, the remainder will be the dividend and quotient will be zero,
            // as no subtractions will occur.
            if (temp_remainder >= divisor && divisor != 0) begin
                temp_remainder = temp_remainder - divisor;
                temp_quotient = temp_quotient + 1;
            end
            // No 'else' block is strictly needed, as temp_quotient and temp_remainder
            // will naturally retain their values from the previous iteration if the 'if' condition is false.
        end

        // Assign the final computed values to the output registers after the loop completes
        quotient = temp_quotient;
        remainder = temp_remainder;
    end
endmodule
