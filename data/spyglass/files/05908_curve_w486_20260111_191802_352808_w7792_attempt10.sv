module curve_w486_20260111_191802_352808_w7792_attempt10 (
    input clk,
    input rst_n,
    input [9:0] data_in_a, // 10 bits
    input [9:0] data_in_b, // 10 bits
    output reg [7:0] data_out // 8 bits
);

    // This module is designed to trigger exactly one W486 violation.
    // Rule: Rhs width 'X' with shift (Expr: '...') is more than lhs width 'Y' (Expr: '...'), this may cause overflow.
    
    // Explanation of the violation:
    // 1. The operands `data_in_a` and `data_in_b` are both 10 bits wide.
    // 2. The sum `(data_in_a + data_in_b)` can range up to (2^10 - 1) + (2^10 - 1) = 1023 + 1023 = 2046.
    // 3. To represent the value 2046, 11 bits are required (since 2^10 = 1024, and 2^11 = 2048).
    //    Therefore, the expression `(data_in_a + data_in_b)` has an effective semantic width of 11 bits.
    // 4. The right-shift operation `>> 1` on an 11-bit expression, for the purpose of this rule, typically preserves the conceptual width of the unshifted expression.
    //    So, the RHS `(data_in_a + data_in_b) >> 1` is considered 11 bits wide.
    // 5. The LHS `data_out` is declared as `reg [7:0]`, making it 8 bits wide.
    // 6. Since the RHS width (11 bits) is greater than the LHS width (8 bits), this will trigger the W486 violation.
    //    The output `data_out` will implicitly truncate the most significant bits of the RHS expression.

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 8'h00;
        end else begin
            data_out <= (data_in_a + data_in_b) >> 1; // Expected W486 violation: 11-bit RHS assigned to 8-bit LHS
        end
    end

endmodule
