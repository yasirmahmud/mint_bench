module curve_w224_20260111_083212_attempt3 (
    input wire clk,
    input wire rst_n,
    output reg is_empty_flag
);

reg [2:0] count; // Multi-bit register

// Synchronous counter to ensure 'count' is used and changes value
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 3'b0;
    end else begin
        count <= count + 3'b1; // Simple counter
    end
end

// Trigger W224: Multi-bit expression 'count' found when one-bit expression expected.
// The conditional expression (ternary operator '? :') expects a 1-bit boolean condition.
// Using 'count' (a multi-bit expression) as the condition will cause an implicit
// conversion to a 1-bit boolean (non-zero treated as true, zero as false).
// This implicit conversion triggers W224.
always @(*) begin
    is_empty_flag <= count ? 1'b0 : 1'b1;
end

endmodule
