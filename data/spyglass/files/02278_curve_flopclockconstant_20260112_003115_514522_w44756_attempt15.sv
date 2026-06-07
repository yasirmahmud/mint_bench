module curve_flopclockconstant_20260112_003115_514522_w44756_attempt15 (
    input wire i_data1,
    input wire i_data2,
    output reg o_q1,
    output reg o_q2
);

    // Declare wires that will represent constant '0' clocks for the flip-flops.
    wire clk_gnd1;
    wire clk_gnd2;

    // Tie the clock wires to a constant logic '0'.
    // This creates the condition for the FlopClockConstant violation, as the clock
    // input to the inferred flip-flops will be tied low.
    assign clk_gnd1 = 1'b0;
    assign clk_gnd2 = 1'b0;

    // First always block: infers a flip-flop clocked by 'clk_gnd1'.
    // Since 'clk_gnd1' is tied to '0', this triggers the first FlopClockConstant violation.
    always @(posedge clk_gnd1) begin
        o_q1 <= i_data1;
    end

    // Second always block: infers another flip-flop clocked by 'clk_gnd2'.
    // Since 'clk_gnd2' is also tied to '0', this triggers the second FlopClockConstant violation,
    // fulfilling the requirement for 2 total occurrences.
    always @(posedge clk_gnd2) begin
        o_q2 <= i_data2;
    end

endmodule
