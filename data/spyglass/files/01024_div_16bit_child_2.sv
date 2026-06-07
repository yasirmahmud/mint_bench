module div_16bit(
    input [15:0] A,      // 16-bit dividend
    input [7:0] B,       // 8-bit divisor
    output reg [15:0] result, // 16-bit quotient
    output reg [15:0] odd     // 16-bit remainder
);

    // Temporary registers to hold intermediate values and shifted divisor
    reg [15:0] current_dividend_reg; // Holds dividend state through loop
    reg [15:0] current_remainder_reg; // Holds remainder state through loop
    reg [15:0] current_result_reg; // Holds quotient state through loop
    reg [15:0] divisor_reg; // Divisor is constant after initialization

    // Temporary variables for values computed within each iteration (moved from inside the always block for Verilog-2001 compatibility)
    reg [15:0] next_shifted_remainder_val;
    reg [15:0] next_remainder_val_for_this_iter;
    reg [15:0] next_result_val_for_this_iter;

    integer i;

    always @* begin
        // Initialize the values
        current_dividend_reg = A;
        divisor_reg = {B, 8'd0}; // Align the divisor with the higher bits of the dividend
        current_remainder_reg = 0;
        current_result_reg = 0;

        // Loop to process each bit from MSB to LSB
        for (i = 0; i < 16; i = i + 1) begin
            // Step 1: Shift current remainder and bring down the next bit of the dividend
            next_shifted_remainder_val = (current_remainder_reg << 1) | (current_dividend_reg[15] & 1'b1);
            
            // Step 2: Shift the current_dividend_reg for the next iteration
            current_dividend_reg = current_dividend_reg << 1; // This is assigned once per loop iteration

            // Step 3: Compare the shifted remainder with the divisor and update values
            if (next_shifted_remainder_val >= divisor_reg) begin
                next_remainder_val_for_this_iter = next_shifted_remainder_val - divisor_reg;
                next_result_val_for_this_iter = (current_result_reg << 1) | 1'b1;
            end else begin
                next_remainder_val_for_this_iter = next_shifted_remainder_val;
                next_result_val_for_this_iter = current_result_reg << 1;
            end
            
            // Step 4: Assign the computed values to the state registers (ensuring single assignment to current_remainder_reg and current_result_reg per iteration)
            current_remainder_reg = next_remainder_val_for_this_iter;
            current_result_reg = next_result_val_for_this_iter;
        end

        // Assign the final remainder value to output 'odd'
        odd = current_remainder_reg;
        // Assign the final quotient value to output 'result'
        result = current_result_reg;
    end

endmodule
