module curve_flopclockconstant_20260112_003115_514522_w44756_attempt16 (
    input wire d_in_a,
    input wire d_in_b,
    output reg q_out_a,
    output reg q_out_b
);

    // Wires that will be tied to logic '0' to act as constant clocks.
    wire clk_low_a;
    wire clk_low_b;

    // Tie the clock wires to a constant logic '0'.
    // This creates the condition for the FlopClockConstant violation, as the clock
    // input to the inferred flip-flops will be tied low.
    assign clk_low_a = 1'b0;
    assign clk_low_b = 1'b0;

    // First sequential block: infers a flip-flop clocked by 'clk_low_a'.
    // Since 'clk_low_a' is constant '0', this triggers the first FlopClockConstant violation.
    always @(posedge clk_low_a) begin
        q_out_a <= d_in_a;
    end

    // Second sequential block: infers another flip-flop clocked by 'clk_low_b'.
    // Since 'clk_low_b' is also constant '0', this triggers the second FlopClockConstant violation,
    // fulfilling the requirement for 2 total occurrences.
    always @(posedge clk_low_b) begin
        q_out_b <= d_in_b;
    end

endmodule
