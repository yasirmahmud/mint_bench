module curve_flopclockconstant_20260112_003115_514522_w44756_attempt13 (
    input wire i_data1,
    input wire i_data2,
    output reg o_q1,
    output reg o_q2
);

    // Declare constant clock signals
    wire clk_const_0a;
    wire clk_const_0b;

    assign clk_const_0a = 1'b0;
    assign clk_const_0b = 1'b0;

    // This first always block uses a constant '0' as its clock,
    // triggering a FlopClockConstant violation.
    always @(posedge clk_const_0a) begin
        o_q1 <= i_data1;
    end

    // This second always block also uses a constant '0' as its clock,
    // triggering a second FlopClockConstant violation, meeting the requirement for 2 total occurrences.
    always @(posedge clk_const_0b) begin
        o_q2 <= i_data2;
    end

endmodule
