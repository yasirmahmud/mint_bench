module curve_w224_20260111_083212_attempt5 (
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
        counter <= counter + 3'b1;
    end
end

// Trigger W224: Multi-bit expression 'counter' found when one-bit expression expected.
// The 'counter' variable is a 3-bit expression. When used as the condition
// for an 'if' statement, it is implicitly converted to a 1-bit boolean
// (non-zero treated as true, zero as false). This implicit conversion
// from a multi-bit expression to a one-bit expression is what W224 flags.
always @(*) begin
    if (counter) begin // 'counter' is a multi-bit expression used where a 1-bit boolean is expected
        flag_out = 1'b1;
    end else begin
        flag_out = 1'b0;
    end
end

endmodule
