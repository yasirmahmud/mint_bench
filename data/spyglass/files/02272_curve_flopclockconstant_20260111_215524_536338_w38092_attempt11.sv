module curve_flopclockconstant_20260111_215524_536338_w38092_attempt11 (
    input wire i_data1,
    input wire i_data2,
    output reg o_q1,
    output reg o_q2
);

    // Declare a wire and tie it to a constant '0' for the clock signal.
    wire clk_constant_low = 1'b0;

    // First flip-flop: its clock pin 'clk_constant_low' is tied low,
    // leading to a FlopClockConstant violation.
    always @(posedge clk_constant_low) begin
        o_q1 <= i_data1;
    end

    // Second flip-flop: its clock pin 'clk_constant_low' is also tied low.
    // This ensures a second occurrence of the FlopClockConstant violation,
    // meeting the requirement for 2 total occurrences.
    always @(posedge clk_constant_low) begin
        o_q2 <= i_data2;
    end

endmodule
