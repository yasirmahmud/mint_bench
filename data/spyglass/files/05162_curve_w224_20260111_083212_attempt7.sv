module curve_w224_20260111_083212_attempt7 (
    input wire clk,
    input wire rst_n,
    output reg flag_out
);

reg [1:0] count_multibit; // A multi-bit expression

// Increment count_multibit to ensure it's used and changes value
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count_multibit <= 2'b0;
    end else begin
        // Increment and roll over to keep it active
        count_multibit <= count_multibit + 2'b1;
    end
end

// Trigger W224: Multi-bit expression 'count_multibit' found when one-bit expression expected.
always @(*) begin
    // The 'count_multibit' variable (2-bit) is used as the condition for the ternary operator (?:).
    // A multi-bit expression in this context is implicitly converted to a 1-bit boolean
    // (non-zero treated as true, zero as false), which is flagged by W224.
    flag_out = count_multibit ? 1'b1 : 1'b0;
end

endmodule
