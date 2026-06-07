module curve_w486_20260111_191802_352808_w7792_attempt8 (
    input clk,
    input rst_n,
    input [9:0] data_in_a, // 10 bits
    input [8:0] data_in_b, // 9 bits
    output reg [7:0] result_out // 8 bits
);

    // This module triggers a W486 violation.
    // The expression `(data_in_a + data_in_b)` involves operands of 10 and 9 bits.
    // The maximum possible value for `data_in_a` is 1023 (2^10 - 1).
    // The maximum possible value for `data_in_b` is 511 (2^9 - 1).
    // The sum `data_in_a + data_in_b` can be up to `1023 + 511 = 1534`.
    // This value (1534) requires 11 bits to represent (as 2^10 = 1024, 2^11 = 2048).
    // Therefore, the RHS expression `(data_in_a + data_in_b)` effectively
    // has a semantic width of 11 bits. The `>> 1` shift maintains this width.
    // So, the total RHS expression `(data_in_a + data_in_b) >> 1` has a semantic width of 11 bits.
    // The LHS `result_out` is 8 bits.
    // SpyGlass is expected to flag W486: Rhs width '11' with shift (Expr: '...') is more than lhs width '8'.

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result_out <= 8'h00;
        end else begin
            result_out <= (data_in_a + data_in_b) >> 1; // Expected W486 violation
        end
    end

endmodule
