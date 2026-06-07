module curve_w224_20260111_083212_attempt9 (
    input wire clk,
    input wire reset_n,
    input wire enable,
    output reg is_non_zero
);

reg [2:0] data_count; // A multi-bit expression

// Update data_count to ensure it's active and used, preventing unused signal warnings.
// This also provides a dynamic value for the multi-bit expression.
always @(posedge clk) begin
    if (!reset_n) begin
        data_count <= 3'd0;
    end else if (enable) begin
        data_count <= data_count + 3'd1;
    end
end

// Trigger W224: Multi-bit expression 'data_count' found when one-bit expression expected.
// The conditional (ternary) operator '?:' expects a single-bit boolean expression
// for its condition. When 'data_count' (a 3-bit signal) is used as the condition,
// it is implicitly converted to a 1-bit value (non-zero becomes 1'b1, zero becomes 1'b0).
// This implicit conversion of a multi-bit expression to a 1-bit context directly
// triggers the W224 violation.
always @(*) begin
    is_non_zero = data_count ? 1'b1 : 1'b0; // Violation here: 'data_count' is multi-bit
end

endmodule
