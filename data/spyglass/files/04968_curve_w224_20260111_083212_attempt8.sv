module curve_w224_20260111_083212_attempt8 (
    input wire clk,
    input wire enable_in,
    output reg done_flag
);

reg [1:0] state_counter; // A multi-bit expression

// Increment the counter to ensure it's active and used
always @(posedge clk) begin
    state_counter <= state_counter + 2'b1;
end

// Trigger W224: Multi-bit expression 'state_counter' found when one-bit expression expected.
// 'state_counter' (2-bit) is used as an operand in a logical AND (&&) operation.
// The '&&' operator expects boolean (1-bit) operands, so 'state_counter' is implicitly
// converted to a 1-bit value (non-zero -> 1, zero -> 0), which triggers W224.
always @(*) begin
    if (enable_in && state_counter) begin
        done_flag = 1'b1;
    end else begin
        done_flag = 1'b0;
    end
end

endmodule
