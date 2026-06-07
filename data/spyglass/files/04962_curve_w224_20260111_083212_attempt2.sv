module curve_w224_20260111_083212_attempt2 (
    input wire clk,
    input wire rst_n,
    input wire enable_condition,
    output reg final_output
);

reg [2:0] count; // Multi-bit register

// Synchronous counter to ensure 'count' is used and changes value
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 3'b0;
    end else begin
        if (enable_condition) begin
            count <= count + 3'b1;
        end
    end
end

// Trigger W224: Multi-bit expression 'count' found when one-bit expression expected.
// The logical AND ('&&') operator expects 1-bit boolean operands.
// When 'count' (a multi-bit expression) is used as an operand,
// it is implicitly converted to a 1-bit boolean value (non-zero treated as true).
// This implicit conversion of a multi-bit value to a 1-bit boolean 
// is intended to trigger W224 without also triggering STARC05-2.1.5.3 
// (Conditional expression does not evaluate to a scalar), as 'count' is
// an operand in a logical operation rather than a direct conditional expression.
always @(*) begin
    final_output <= count && enable_condition;
end

endmodule
