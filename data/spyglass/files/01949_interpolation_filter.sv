module interpolation_filter(
    multi1_a,
    multi1_b,
    multi2_a,
    multi2_b,
    multi3_a,
    multi3_b,
    multi4_a,
    multi4_b,
    multi5_a,
    multi5_b,
    multi6_a,
    multi6_b,
    multi7_a,
    multi7_b,
    multi8_a,
    multi8_b,
    CLK, rst,
    output_real,
    output_img);
    
    input     CLK,rst;
    input     [15:0] multi1_a, multi2_a, multi3_a, multi4_a, multi5_a, multi6_a, multi7_a, multi8_a;
    input     [9:0]  multi1_b, multi2_b, multi3_b, multi4_b;
    input     [9:0]  multi5_b, multi6_b, multi7_b, multi8_b;
    output    [15:0] output_real,output_img;
    wire      [15:0] output_z_1, output_z_2, output_z_3, output_z_4, output_z_5, output_z_6, output_z_7, output_z_8; 

    wire     [15:0]  multi1_b_ck, multi2_b_ck, multi3_b_ck, multi4_b_ck;
    wire     [15:0]  multi5_b_ck, multi6_b_ck, multi7_b_ck, multi8_b_ck;
    assign multi1_b_ck = {multi1_b,6'd0};
    assign multi2_b_ck = {multi2_b,6'd0};
    assign multi3_b_ck = {multi3_b,6'd0};
    assign multi4_b_ck = {multi4_b,6'd0};
    assign multi5_b_ck = {multi5_b,6'd0};
    assign multi6_b_ck = {multi6_b,6'd0};
    assign multi7_b_ck = {multi7_b,6'd0};
    assign multi8_b_ck = {multi8_b,6'd0};

    complex_multiplier DUT_MM_1(
    .CLK(CLK), .rst(rst), 
    .input_a_real(multi1_a),
    .input_b_real(multi1_b),
    .input_a_imag(multi5_a),
    .input_b_imag(multi5_b),
    .output_z_real(output_z_1),
    .output_z_imag(output_z_5)
    );

    complex_multiplier DUT_MM_2(
    .CLK(CLK), .rst(rst), 
    .input_a_real(multi2_a),
    .input_b_real(multi2_b),
    .input_a_imag(multi6_a),
    .input_b_imag(multi6_b),
    .output_z_real(output_z_2),
    .output_z_imag(output_z_6)
    );

    complex_multiplier DUT_MM_3(
    .CLK(CLK), .rst(rst), 
    .input_a_real(multi3_a),
    .input_b_real(multi3_b),
    .input_a_imag(multi7_a),
    .input_b_imag(multi7_b),
    .output_z_real(output_z_3),
    .output_z_imag(output_z_7)
    );

    complex_multiplier DUT_MM_4(
    .CLK(CLK), .rst(rst), 
    .input_a_real(multi4_a),
    .input_b_real(multi4_b),
    .input_a_imag(multi8_a),
    .input_b_imag(multi8_b),
    .output_z_real(output_z_4),
    .output_z_imag(output_z_8)
    );
    //Adder 
    wire      [15:0] output_s_1, output_s_2, output_s_3, output_s_4;


    adder_16bit U9(
        .input_a(output_z_1),
        .input_b(output_z_2),
        .CLK(CLK),.Reset(rst),
        .output_z(output_s_1)
    );

    adder_16bit U10(
        .input_a(output_z_3),
        .input_b(output_z_4),
        .CLK(CLK),.Reset(rst),
        .output_z(output_s_2)
    );

    adder_16bit U11(
        .input_a(output_z_5),
        .input_b(output_z_6),
        .CLK(CLK),.Reset(rst),
        .output_z(output_s_3)
    );

    adder_16bit U12(
        .input_a(output_z_7),
        .input_b(output_z_8),
        .CLK(CLK),.Reset(rst),
        .output_z(output_s_4)
    );

    adder_16bit U13(
        .input_a(output_s_1),
        .input_b(output_s_2),
        .CLK(CLK),.Reset(rst),
        .output_z(output_real)
    );

    adder_16bit U14(
        .input_a(output_s_3),
        .input_b(output_s_4),
        .CLK(CLK),.Reset(rst),
        .output_z(output_img)
    );

endmodule
