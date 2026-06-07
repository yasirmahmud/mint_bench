module curve_w224_20260111_083212_attempt4 (
    input wire clk,
    input wire rst_n,
    input wire enable_condition,
    output reg output_flag
);

reg [2:0] state_reg; // Multi-bit expression

// Example logic for state_reg to ensure it's used and changes value
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state_reg <= 3'b0;
    end else begin
        state_reg <= state_reg + 3'b1;
    end
end

// Trigger W224: Multi-bit expression '~state_reg' found when one-bit expression expected.
// The bitwise NOT operator (~) on a multi-bit signal 'state_reg' results in a multi-bit expression.
// When this multi-bit expression (~state_reg) is used as an operand for the logical AND (&&) operator,
// it is implicitly converted to a one-bit boolean value (non-zero treated as 1, zero as 0).
// This implicit conversion of a multi-bit expression to a one-bit expression is flagged by W224.
always @(*) begin
    if (enable_condition && ~state_reg) begin // '~state_reg' is a multi-bit expression
        output_flag = 1'b1;
    end else begin
        output_flag = 1'b0;
    end
end

endmodule
