module curve_w224_20260111_083212_attempt6 (
    input wire clk,
    input wire rst_n,
    output reg flag_out
);

reg [2:0] counter; // A multi-bit expression

// Increment counter to ensure it's used and changes value
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <= 3'b0;
    end else begin
        counter <= counter + 3'b1; // Rollover is fine for demonstration
    end
end

// Trigger W224: Multi-bit expression 'counter' found when one-bit expression expected.
// The 'counter' variable is a 3-bit expression. When used as the operand
// for the logical NOT (!) operator, it is implicitly converted to a 1-bit
// boolean (non-zero treated as true, zero as false) before negation.
// This implicit conversion from a multi-bit expression to a one-bit expression
// for the logical operation is what W224 flags.
// The resulting expression '!counter' itself is a 1-bit (scalar) boolean,
// which should avoid triggering rules like STARC05-2.1.5.3
// ("Conditional expression does not evaluate to a scalar") on the 'if' condition itself.
always @(*) begin
    if (!counter) begin // 'counter' is a multi-bit expression used inside a logical operation
        flag_out = 1'b1;
    end else begin
        flag_out = 1'b0;
    end
end

endmodule
