module curve_flopclockconstant_20260111_215524_536338_w38092_attempt12 (
    input wire i_data_a,
    input wire i_data_b,
    output reg o_reg_a,
    output reg o_reg_b
);

    // Declare two distinct wires and tie them to constant '0' for clock signals.
    // Each of these will cause a 'FlopClockConstant' violation.
    wire clk_const_gnd_a = 1'b0;
    wire clk_const_gnd_b = 1'b0;

    // First flip-flop: its clock pin 'clk_const_gnd_a' is tied low.
    // This triggers the first 'FlopClockConstant' violation.
    always @(posedge clk_const_gnd_a) begin
        o_reg_a <= i_data_a;
    end

    // Second flip-flop: its clock pin 'clk_const_gnd_b' is also tied low.
    // This triggers the second 'FlopClockConstant' violation, meeting the requirement for 2 total occurrences.
    always @(posedge clk_const_gnd_b) begin
        o_reg_b <= i_data_b;
    end

endmodule
