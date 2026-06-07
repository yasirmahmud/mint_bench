module interpolation_filter (
    input [15:0] multi1_a, input [15:0] multi2_a, input [15:0] multi3_a, input [15:0] multi4_a,
    input [15:0] multi5_a, input [15:0] multi6_a, input [15:0] multi7_a, input [15:0] multi8_a,
    input [9:0] multi1_b, input [9:0] multi2_b, input [9:0] multi3_b, input [9:0] multi4_b,
    input [9:0] multi5_b, input [9:0] multi6_b, input [9:0] multi7_b, input [9:0] multi8_b,
    input CLK,
    input rst,
    output reg [15:0] output_real,
    output reg [15:0] output_img
);
    wire signed [25:0] mul_r1_rc1, mul_i1_ic1, mul_r1_ic1, mul_i1_rc1;
    wire signed [25:0] mul_r2_rc2, mul_i2_ic2, mul_r2_ic2, mul_i2_rc2;
    wire signed [25:0] mul_r3_rc3, mul_i3_ic3, mul_r3_ic3, mul_i3_rc3;
    wire signed [25:0] mul_r4_rc4, mul_i4_ic4, mul_r4_ic4, mul_i4_rc4;

    assign mul_r1_rc1 = $signed(multi1_a) * $signed(multi1_b);
    assign mul_i1_ic1 = $signed(multi5_a) * $signed(multi5_b);
    assign mul_r1_ic1 = $signed(multi1_a) * $signed(multi5_b);
    assign mul_i1_rc1 = $signed(multi5_a) * $signed(multi1_b);

    assign mul_r2_rc2 = $signed(multi2_a) * $signed(multi2_b);
    assign mul_i2_ic2 = $signed(multi6_a) * $signed(multi6_b);
    assign mul_r2_ic2 = $signed(multi2_a) * $signed(multi6_b);
    assign mul_i2_rc2 = $signed(multi6_a) * $signed(multi2_b);

    assign mul_r3_rc3 = $signed(multi3_a) * $signed(multi3_b);
    assign mul_i3_ic3 = $signed(multi7_a) * $signed(multi7_b);
    assign mul_r3_ic3 = $signed(multi3_a) * $signed(multi7_b);
    assign mul_i3_rc3 = $signed(multi7_a) * $signed(multi3_b);

    assign mul_r4_rc4 = $signed(multi4_a) * $signed(multi4_b);
    assign mul_i4_ic4 = $signed(multi8_a) * $signed(multi8_b);
    assign mul_r4_ic4 = $signed(multi4_a) * $signed(multi8_b);
    assign mul_i4_rc4 = $signed(multi8_a) * $signed(multi4_b);

    wire signed [27:0] sum_real_contributions;
    wire signed [27:0] sum_imag_contributions;

    assign sum_real_contributions = (mul_r1_rc1 - mul_i1_ic1) +
                                    (mul_r2_rc2 - mul_i2_ic2) +
                                    (mul_r3_rc3 - mul_i3_ic3) +
                                    (mul_r4_rc4 - mul_i4_ic4);

    assign sum_imag_contributions = (mul_r1_ic1 + mul_i1_rc1) +
                                    (mul_r2_ic2 + mul_i2_rc2) +
                                    (mul_r3_ic3 + mul_i3_rc3) +
                                    (mul_r4_ic4 + mul_i4_rc4);

    always @(posedge CLK or posedge rst) begin
        if (rst) begin
            output_real <= 16'd0;
            output_img  <= 16'd0;
        end else begin
            output_real <= sum_real_contributions[15:0];
            output_img  <= sum_imag_contributions[15:0];
        end
    end
endmodule
