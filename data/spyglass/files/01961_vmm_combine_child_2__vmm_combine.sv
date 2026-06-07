module vmm_combine(
CLK, rst,
input_a_real1_vmm0, input_a_real2_vmm0,  input_a_real3_vmm0,  input_a_real4_vmm0,  input_a_real5_vmm0,  input_a_real6_vmm0,  input_a_real7_vmm0,  input_a_real8_vmm0,
input_a_imag1_vmm0, input_a_imag2_vmm0,  input_a_imag3_vmm0,  input_a_imag4_vmm0,  input_a_imag5_vmm0,  input_a_imag6_vmm0,  input_a_imag7_vmm0,  input_a_imag8_vmm0,
input_a_real9_vmm0, input_a_real10_vmm0, input_a_real11_vmm0, input_a_real12_vmm0, input_a_real13_vmm0, input_a_real14_vmm0, input_a_real15_vmm0, input_a_real16_vmm0,
input_a_imag9_vmm0, input_a_imag10_vmm0, input_a_imag11_vmm0, input_a_imag12_vmm0, input_a_imag13_vmm0, input_a_imag14_vmm0, input_a_imag15_vmm0, input_a_imag16_vmm0,
input_b_real1_vmm0, input_b_real2_vmm0,   input_b_real3_vmm0,  input_b_real4_vmm0,  input_b_real5_vmm0,  input_b_real6_vmm0,  input_b_real7_vmm0,  input_b_real8_vmm0,
input_b_imag1_vmm0, input_b_imag2_vmm0,   input_b_imag3_vmm0,  input_b_imag4_vmm0,  input_b_imag5_vmm0,  input_b_imag6_vmm0,  input_b_imag7_vmm0,  input_b_imag8_vmm0,
input_b_real9_vmm0, input_b_real10_vmm0, input_b_real11_vmm0, input_b_real12_vmm0, input_b_real13_vmm0, input_b_real14_vmm0, input_b_real15_vmm0, input_b_real16_vmm0,
input_b_imag9_vmm0, input_b_imag10_vmm0, input_b_imag11_vmm0, input_b_imag12_vmm0, input_b_imag13_vmm0, input_b_imag14_vmm0, input_b_imag15_vmm0, input_b_imag16_vmm0,
input_a_real1_vmm1, input_a_real2_vmm1,  input_a_real3_vmm1,  input_a_real4_vmm1,  input_a_real5_vmm1,  input_a_real6_vmm1,  input_a_real7_vmm1,  input_a_real8_vmm1,
input_a_imag1_vmm1, input_a_imag2_vmm1,  input_a_imag3_vmm1,  input_a_imag4_vmm1,  input_a_imag5_vmm1,  input_a_imag6_vmm1,  input_a_imag7_vmm1,  input_a_imag8_vmm1,
input_a_real9_vmm1, input_a_real10_vmm1, input_a_real11_vmm1, input_a_real12_vmm1, input_a_real13_vmm1, input_a_real14_vmm1, input_a_real15_vmm1, input_a_real16_vmm1,
input_a_imag9_vmm1, input_a_imag10_vmm1, input_a_imag11_vmm1, input_a_imag12_vmm1, input_a_imag13_vmm1, input_a_imag14_vmm1, input_a_imag15_vmm1, input_a_imag16_vmm1,
input_b_real1_vmm1, input_b_real2_vmm1,   input_b_real3_vmm1,  input_b_real4_vmm1,  input_b_real5_vmm1,  input_b_real6_vmm1,  input_b_real7_vmm1,  input_b_real8_vmm1,
input_b_imag1_vmm1, input_b_imag2_vmm1,   input_b_imag3_vmm1,  input_b_imag4_vmm1,  input_b_imag5_vmm1,  input_b_imag6_vmm1,  input_b_imag7_vmm1,  input_b_imag8_vmm1,
input_b_real9_vmm1, input_b_real10_vmm1, input_b_real11_vmm1, input_b_real12_vmm1, input_b_real13_vmm1, input_b_real14_vmm1, input_b_real15_vmm1, input_b_real16_vmm1,
input_b_imag9_vmm1, input_b_imag10_vmm1, input_b_imag11_vmm1, input_b_imag12_vmm1, input_b_imag13_vmm1, input_b_imag14_vmm1, input_b_imag15_vmm1, input_b_imag16_vmm1,
input_a_real1_vmm2, input_a_real2_vmm2,  input_a_real3_vmm2,  input_a_real4_vmm2,  input_a_real5_vmm2,  input_a_real6_vmm2,  input_a_real7_vmm2,  input_a_real8_vmm2,
input_a_imag1_vmm2, input_a_imag2_vmm2,  input_a_imag3_vmm2,  input_a_imag4_vmm2,  input_a_imag5_vmm2,  input_a_imag6_vmm2,  input_a_imag7_vmm2,  input_a_imag8_vmm2,
input_a_real9_vmm2, input_a_real10_vmm2, input_a_real11_vmm2, input_a_real12_vmm2, input_a_real13_vmm2, input_a_real14_vmm2, input_a_real15_vmm2, input_a_real16_vmm2,
input_a_imag9_vmm2, input_a_imag10_vmm2, input_a_imag11_vmm2, input_a_imag12_vmm2, input_a_imag13_vmm2, input_a_imag14_vmm2, input_a_imag15_vmm2, input_a_imag16_vmm2,
input_b_real1_vmm2, input_b_real2_vmm2,   input_b_real3_vmm2,  input_b_real4_vmm2,  input_b_real5_vmm2,  input_b_real6_vmm2,  input_b_real7_vmm2,  input_b_real8_vmm2,
input_b_imag1_vmm2, input_b_imag2_vmm2,   input_b_imag3_vmm2,  input_b_imag4_vmm2,  input_b_imag5_vmm2,  input_b_imag6_vmm2,  input_b_imag7_vmm2,  input_b_imag8_vmm2,
input_b_real9_vmm2, input_b_real10_vmm2, input_b_real11_vmm2, input_b_real12_vmm2, input_b_real13_vmm2, input_b_real14_vmm2, input_b_real15_vmm2, input_b_real16_vmm2,
input_b_imag9_vmm2, input_b_imag10_vmm2, input_b_imag11_vmm2, input_b_imag12_vmm2, input_b_imag13_vmm2, input_b_imag14_vmm2, input_b_imag15_vmm2, input_b_imag16_vmm2,
input_a_real1_vmm3, input_a_real2_vmm3,  input_a_real3_vmm3,  input_a_real4_vmm3,  input_a_real5_vmm3,  input_a_real6_vmm3,  input_a_real7_vmm3,  input_a_real8_vmm3,
input_a_imag1_vmm3, input_a_imag2_vmm3,  input_a_imag3_vmm3,  input_a_imag4_vmm3,  input_a_imag5_vmm3,  input_a_imag6_vmm3,  input_a_imag7_vmm3,  input_a_imag8_vmm3,
input_a_real9_vmm3, input_a_real10_vmm3, input_a_real11_vmm3, input_a_real12_vmm3, input_a_real13_vmm3, input_a_real14_vmm3, input_a_real15_vmm3, input_a_real16_vmm3,
input_a_imag9_vmm3, input_a_imag10_vmm3, input_a_imag11_vmm3, input_a_imag12_vmm3, input_a_imag13_vmm3, input_a_imag14_vmm3, input_a_imag15_vmm3, input_a_imag16_vmm3,
input_b_real1_vmm3, input_b_real2_vmm3,   input_b_real3_vmm3,  input_b_real4_vmm3,  input_b_real5_vmm3,  input_b_real6_vmm3,  input_b_real7_vmm3,  input_b_real8_vmm3,
input_b_imag1_vmm3, input_b_imag2_vmm3,   input_b_imag3_vmm3,  input_b_imag4_vmm3,  input_b_imag5_vmm3,  input_b_imag6_vmm3,  input_b_imag7_vmm3,  input_b_imag8_vmm3,
input_b_real9_vmm3, input_b_real10_vmm3, input_b_real11_vmm3, input_b_real12_vmm3, input_b_real13_vmm3, input_b_real14_vmm3, input_b_real15_vmm3, input_b_real16_vmm3,
input_b_imag9_vmm3, input_b_imag10_vmm3, input_b_imag11_vmm3, input_b_imag12_vmm3, input_b_imag13_vmm3, input_b_imag14_vmm3, input_b_imag15_vmm3, input_b_imag16_vmm3,
output_z_real1_vmm0, output_z_real2_vmm0,  output_z_real3_vmm0,  output_z_real4_vmm0,  output_z_real5_vmm0,  output_z_real6_vmm0,  output_z_real7_vmm0,  output_z_real8_vmm0,
output_z_imag1_vmm0, output_z_imag2_vmm0,  output_z_imag3_vmm0,  output_z_imag4_vmm0,  output_z_imag5_vmm0,  output_z_imag6_vmm0,  output_z_imag7_vmm0,  output_z_imag8_vmm0,
output_z_real9_vmm0, output_z_real10_vmm0, output_z_real11_vmm0, output_z_real12_vmm0, output_z_real13_vmm0, output_z_real14_vmm0, output_z_real15_vmm0, output_z_real16_vmm0,
output_z_imag9_vmm0, output_z_imag10_vmm0, output_z_imag11_vmm0, output_z_imag12_vmm0, output_z_imag13_vmm0, output_z_imag14_vmm0, output_z_imag15_vmm0, output_z_imag16_vmm0,
output_z_real1_vmm1, output_z_real2_vmm1,  output_z_real3_vmm1,  output_z_real4_vmm1,  output_z_real5_vmm1,  output_z_real6_vmm1,  output_z_real7_vmm1,  output_z_real8_vmm1,
output_z_imag1_vmm1, output_z_imag2_vmm1,  output_z_imag3_vmm1,  output_z_imag4_vmm1,  output_z_imag5_vmm1,  output_z_imag6_vmm1,  output_z_imag7_vmm1,  output_z_imag8_vmm1,
output_z_real9_vmm1, output_z_real10_vmm1, output_z_real11_vmm1, output_z_real12_vmm1, output_z_real13_vmm1, output_z_real14_vmm1, output_z_real15_vmm1, output_z_real16_vmm1,
output_z_imag9_vmm1, output_z_imag10_vmm1, output_z_imag11_vmm1, output_z_imag12_vmm1, output_z_imag13_vmm1, output_z_imag14_vmm1, output_z_imag15_vmm1, output_z_imag16_vmm1,
output_z_real1_vmm2, output_z_real2_vmm2,  output_z_real3_vmm2,  output_z_real4_vmm2,  output_z_real5_vmm2,  output_z_real6_vmm2,  output_z_real7_vmm2,  output_z_real8_vmm2,
output_z_imag1_vmm2, output_z_imag2_vmm2,  output_z_imag3_vmm2,  output_z_imag4_vmm2,  output_z_imag5_vmm2,  output_z_imag6_vmm2,  output_z_imag7_vmm2,  output_z_imag8_vmm2,
output_z_real9_vmm2, output_z_real10_vmm2, output_z_real11_vmm2, output_z_real12_vmm2, output_z_real13_vmm2, output_z_real14_vmm2, output_z_real15_vmm2, output_z_real16_vmm2,
output_z_imag9_vmm2, output_z_imag10_vmm2, output_z_imag11_vmm2, output_z_imag12_vmm2, output_z_imag13_vmm2, output_z_imag14_vmm2, output_z_imag15_vmm2, output_z_imag16_vmm2,
output_z_real1_vmm3, output_z_real2_vmm3,  output_z_real3_vmm3,  output_z_real4_vmm3,  output_z_real5_vmm3,  output_z_real6_vmm3,  output_z_real7_vmm3,  output_z_real8_vmm3,
output_z_imag1_vmm3, output_z_imag2_vmm3,  output_z_imag3_vmm3,  output_z_imag4_vmm3,  output_z_imag5_vmm3,  output_z_imag6_vmm3,  output_z_imag7_vmm3,  output_z_imag8_vmm3,
output_z_real9_vmm3, output_z_real10_vmm3, output_z_real11_vmm3, output_z_real12_vmm3, output_z_real13_vmm3, output_z_real14_vmm3, output_z_real15_vmm3, output_z_real16_vmm3,
output_z_imag9_vmm3, output_z_imag10_vmm3, output_z_imag11_vmm3, output_z_imag12_vmm3, output_z_imag13_vmm3, output_z_imag14_vmm3, output_z_imag15_vmm3, output_z_imag16_vmm3
);

input CLK, rst;
input [15:0] input_a_real1_vmm0, input_a_real2_vmm0,  input_a_real3_vmm0,  input_a_real4_vmm0,  input_a_real5_vmm0,  input_a_real6_vmm0,  input_a_real7_vmm0,  input_a_real8_vmm0;
input [15:0] input_a_imag1_vmm0, input_a_imag2_vmm0,  input_a_imag3_vmm0,  input_a_imag4_vmm0,  input_a_imag5_vmm0,  input_a_imag6_vmm0,  input_a_imag7_vmm0,  input_a_imag8_vmm0;
input [15:0] input_a_real9_vmm0, input_a_real10_vmm0, input_a_real11_vmm0, input_a_real12_vmm0, input_a_real13_vmm0, input_a_real14_vmm0, input_a_real15_vmm0, input_a_real16_vmm0;
input [15:0] input_a_imag9_vmm0, input_a_imag10_vmm0, input_a_imag11_vmm0, input_a_imag12_vmm0, input_a_imag13_vmm0, input_a_imag14_vmm0, input_a_imag15_vmm0, input_a_imag16_vmm0;
input [9:0]  input_b_real1_vmm0, input_b_real2_vmm0,   input_b_real3_vmm0,  input_b_real4_vmm0,  input_b_real5_vmm0,  input_b_real6_vmm0,  input_b_real7_vmm0,  input_b_real8_vmm0;
input [9:0]  input_b_imag1_vmm0, input_b_imag2_vmm0,   input_b_imag3_vmm0,  input_b_imag4_vmm0,  input_b_imag5_vmm0,  input_b_imag6_vmm0,  input_b_imag7_vmm0,  input_b_imag8_vmm0;
input [9:0]  input_b_real9_vmm0, input_b_real10_vmm0, input_b_real11_vmm0, input_b_real12_vmm0, input_b_real13_vmm0, input_b_real14_vmm0, input_b_real15_vmm0, input_b_real16_vmm0;
input [9:0]  input_b_imag9_vmm0, input_b_imag10_vmm0, input_b_imag11_vmm0, input_b_imag12_vmm0, input_b_imag13_vmm0, input_b_imag14_vmm0, input_b_imag15_vmm0, input_b_imag16_vmm0;
output [15:0] output_z_real1_vmm0, output_z_real2_vmm0,  output_z_real3_vmm0,  output_z_real4_vmm0,  output_z_real5_vmm0,  output_z_real6_vmm0,  output_z_real7_vmm0,  output_z_real8_vmm0;
output [15:0] output_z_imag1_vmm0, output_z_imag2_vmm0,  output_z_imag3_vmm0,  output_z_imag4_vmm0,  output_z_imag5_vmm0,  output_z_imag6_vmm0,  output_z_imag7_vmm0,  output_z_imag8_vmm0;
output [15:0] output_z_real9_vmm0, output_z_real10_vmm0, output_z_real11_vmm0, output_z_real12_vmm0, output_z_real13_vmm0, output_z_real14_vmm0, output_z_real15_vmm0, output_z_real16_vmm0;
output [15:0] output_z_imag9_vmm0, output_z_imag10_vmm0, output_z_imag11_vmm0, output_z_imag12_vmm0, output_z_imag13_vmm0, output_z_imag14_vmm0, output_z_imag15_vmm0, output_z_imag16_vmm0;

vmm_single VMM_SINGLE0(
.CLK(CLK), .rst(rst),
.input_a_real1(input_a_real1_vmm0),     .input_a_real2(input_a_real2_vmm0),     .input_a_real3(input_a_real3_vmm0),     .input_a_real4(input_a_real4_vmm0), 
.input_a_real5(input_a_real5_vmm0),     .input_a_real6(input_a_real6_vmm0),     .input_a_real7(input_a_real7_vmm0),     .input_a_real8(input_a_real8_vmm0),
.input_b_real1(input_b_real1_vmm0),     .input_b_real2(input_b_real2_vmm0),     .input_b_real3(input_b_real3_vmm0),     .input_b_real4(input_b_real4_vmm0), 
.input_b_real5(input_b_real5_vmm0),     .input_b_real6(input_b_real6_vmm0),     .input_b_real7(input_b_real7_vmm0),     .input_b_real8(input_b_real8_vmm0),
.input_a_imag1(input_a_imag1_vmm0),     .input_a_imag2(input_a_imag2_vmm0),     .input_a_imag3(input_a_imag3_vmm0),     .input_a_imag4(input_a_imag4_vmm0), 
.input_a_imag5(input_a_imag5_vmm0),     .input_a_imag6(input_a_imag6_vmm0),     .input_a_imag7(input_a_imag7_vmm0),     .input_a_imag8(input_a_imag8_vmm0),
.input_b_imag1(input_b_imag1_vmm0),     .input_b_imag2(input_b_imag2_vmm0),     .input_b_imag3(input_b_imag3_vmm0),     .input_b_imag4(input_b_imag4_vmm0), 
.input_b_imag5(input_b_imag5_vmm0),     .input_b_imag6(input_b_imag6_vmm0),     .input_b_imag7(input_b_imag7_vmm0),     .input_b_imag8(input_b_imag8_vmm0),
.input_a_real9(input_a_real9_vmm0),     .input_a_real10(input_a_real10_vmm0),   .input_a_real11(input_a_real11_vmm0),   .input_a_real12(input_a_real12_vmm0), 
.input_a_real13(input_a_real13_vmm0),   .input_a_real14(input_a_real14_vmm0),   .input_a_real15(input_a_real15_vmm0),   .input_a_real16(input_a_real16_vmm0),
.input_b_real9(input_b_real9_vmm0),     .input_b_real10(input_b_real10_vmm0),   .input_b_real11(input_b_real11_vmm0),   .input_b_real12(input_b_real12_vmm0), 
.input_b_real13(input_b_real13_vmm0),   .input_b_real14(input_b_real14_vmm0),   .input_b_real15(input_b_real15_vmm0),   .input_b_real16(input_b_real16_vmm0),
.input_a_imag9(input_a_imag9_vmm0),     .input_a_imag10(input_a_imag10_vmm0),   .input_a_imag11(input_a_imag11_vmm0),   .input_a_imag12(input_a_imag12_vmm0), 
.input_a_imag13(input_a_imag13_vmm0),   .input_a_imag14(input_a_imag14_vmm0),   .input_a_imag15(input_a_imag15_vmm0),   .input_a_imag16(input_a_imag16_vmm0),
.input_b_imag9(input_b_imag9_vmm0),     .input_b_imag10(input_b_imag10_vmm0),   .input_b_imag11(input_b_imag11_vmm0),   .input_b_imag12(input_b_imag12_vmm0), 
.input_b_imag13(input_b_imag13_vmm0),   .input_b_imag14(input_b_imag14_vmm0),   .input_b_imag15(input_b_imag15_vmm0),   .input_b_imag16(input_b_imag16_vmm0),
.output_z_real1(output_z_real1_vmm0),   .output_z_real2(output_z_real2_vmm0),   .output_z_real3(output_z_real3_vmm0),   .output_z_real4(output_z_real4_vmm0), 
.output_z_real5(output_z_real5_vmm0),   .output_z_real6(output_z_real6_vmm0),   .output_z_real7(output_z_real7_vmm0),   .output_z_real8(output_z_real8_vmm0),
.output_z_imag1(output_z_imag1_vmm0),   .output_z_imag2(output_z_imag2_vmm0),   .output_z_imag3(output_z_imag3_vmm0),   .output_z_imag4(output_z_imag4_vmm0), 
.output_z_imag5(output_z_imag5_vmm0),   .output_z_imag6(output_z_imag6_vmm0),   .output_z_imag7(output_z_imag7_vmm0),   .output_z_imag8(output_z_imag8_vmm0),
.output_z_real9(output_z_real9_vmm0),   .output_z_real10(output_z_real10_vmm0), .output_z_real11(output_z_real11_vmm0), .output_z_real12(output_z_real12_vmm0), 
.output_z_real13(output_z_real13_vmm0), .output_z_real14(output_z_real14_vmm0), .output_z_real15(output_z_real15_vmm0), .output_z_real16(output_z_real16_vmm0),
.output_z_imag9 (output_z_imag9_vmm0),  .output_z_imag10(output_z_imag10_vmm0), .output_z_imag11(output_z_imag11_vmm0), .output_z_imag12(output_z_imag12_vmm0), 
.output_z_imag13(output_z_imag13_vmm0), .output_z_imag14(output_z_imag14_vmm0), .output_z_imag15(output_z_imag15_vmm0), .output_z_imag16(output_z_imag16_vmm0)
);



input [15:0] input_a_real1_vmm1, input_a_real2_vmm1,  input_a_real3_vmm1,  input_a_real4_vmm1,  input_a_real5_vmm1,  input_a_real6_vmm1,  input_a_real7_vmm1,  input_a_real8_vmm1;
input [15:0] input_a_imag1_vmm1, input_a_imag2_vmm1,  input_a_imag3_vmm1,  input_a_imag4_vmm1,  input_a_imag5_vmm1,  input_a_imag6_vmm1,  input_a_imag7_vmm1,  input_a_imag8_vmm1;
input [15:0] input_a_real9_vmm1, input_a_real10_vmm1, input_a_real11_vmm1, input_a_real12_vmm1, input_a_real13_vmm1, input_a_real14_vmm1, input_a_real15_vmm1, input_a_real16_vmm1;
input [15:0] input_a_imag9_vmm1, input_a_imag10_vmm1, input_a_imag11_vmm1, input_a_imag12_vmm1, input_a_imag13_vmm1, input_a_imag14_vmm1, input_a_imag15_vmm1, input_a_imag16_vmm1;
input [9:0]  input_b_real1_vmm1, input_b_real2_vmm1,   input_b_real3_vmm1,  input_b_real4_vmm1,  input_b_real5_vmm1,  input_b_real6_vmm1,  input_b_real7_vmm1,  input_b_real8_vmm1;
input [9:0]  input_b_imag1_vmm1, input_b_imag2_vmm1,   input_b_imag3_vmm1,  input_b_imag4_vmm1,  input_b_imag5_vmm1,  input_b_imag6_vmm1,  input_b_imag7_vmm1,  input_b_imag8_vmm1;
input [9:0]  input_b_real9_vmm1, input_b_real10_vmm1, input_b_real11_vmm1, input_b_real12_vmm1, input_b_real13_vmm1, input_b_real14_vmm1, input_b_real15_vmm1, input_b_real16_vmm1;
input [9:0]  input_b_imag9_vmm1, input_b_imag10_vmm1, input_b_imag11_vmm1, input_b_imag12_vmm1, input_b_imag13_vmm1, input_b_imag14_vmm1, input_b_imag15_vmm1, input_b_imag16_vmm1;
output [15:0] output_z_real1_vmm1, output_z_real2_vmm1,  output_z_real3_vmm1,  output_z_real4_vmm1,  output_z_real5_vmm1,  output_z_real6_vmm1,  output_z_real7_vmm1,  output_z_real8_vmm1;
output [15:0] output_z_imag1_vmm1, output_z_imag2_vmm1,  output_z_imag3_vmm1,  output_z_imag4_vmm1,  output_z_imag5_vmm1,  output_z_imag6_vmm1,  output_z_imag7_vmm1,  output_z_imag8_vmm1;
output [15:0] output_z_real9_vmm1, output_z_real10_vmm1, output_z_real11_vmm1, output_z_real12_vmm1, output_z_real13_vmm1, output_z_real14_vmm1, output_z_real15_vmm1, output_z_real16_vmm1;
output [15:0] output_z_imag9_vmm1, output_z_imag10_vmm1, output_z_imag11_vmm1, output_z_imag12_vmm1, output_z_imag13_vmm1, output_z_imag14_vmm1, output_z_imag15_vmm1, output_z_imag16_vmm1;

vmm_single VMM_SINGLE1(
.CLK(CLK), .rst(rst),
.input_a_real1(input_a_real1_vmm1),     .input_a_real2(input_a_real2_vmm1),     .input_a_real3(input_a_real3_vmm1),     .input_a_real4(input_a_real4_vmm1), 
.input_a_real5(input_a_real5_vmm1),     .input_a_real6(input_a_real6_vmm1),     .input_a_real7(input_a_real7_vmm1),     .input_a_real8(input_a_real8_vmm1),
.input_b_real1(input_b_real1_vmm1),     .input_b_real2(input_b_real2_vmm1),     .input_b_real3(input_b_real3_vmm1),     .input_b_real4(input_b_real4_vmm1), 
.input_b_real5(input_b_real5_vmm1),     .input_b_real6(input_b_real6_vmm1),     .input_b_real7(input_b_real7_vmm1),     .input_b_real8(input_b_real8_vmm1),
.input_a_imag1(input_a_imag1_vmm1),     .input_a_imag2(input_a_imag2_vmm1),     .input_a_imag3(input_a_imag3_vmm1),     .input_a_imag4(input_a_imag4_vmm1), 
.input_a_imag5(input_a_imag5_vmm1),     .input_a_imag6(input_a_imag6_vmm1),     .input_a_imag7(input_a_imag7_vmm1),     .input_a_imag8(input_a_imag8_vmm1),
.input_b_imag1(input_b_imag1_vmm1),     .input_b_imag2(input_b_imag2_vmm1),     .input_b_imag3(input_b_imag3_vmm1),     .input_b_imag4(input_b_imag4_vmm1), 
.input_b_imag5(input_b_imag5_vmm1),     .input_b_imag6(input_b_imag6_vmm1),     .input_b_imag7(input_b_imag7_vmm1),     .input_b_imag8(input_b_imag8_vmm1),
.input_a_real9(input_a_real9_vmm1),     .input_a_real10(input_a_real10_vmm1),   .input_a_real11(input_a_real11_vmm1),   .input_a_real12(input_a_real12_vmm1), 
.input_a_real13(input_a_real13_vmm1),   .input_a_real14(input_a_real14_vmm1),   .input_a_real15(input_a_real15_vmm1),   .input_a_real16(input_a_real16_vmm1),
.input_b_real9(input_b_real9_vmm1),     .input_b_real10(input_b_real10_vmm1),   .input_b_real11(input_b_real11_vmm1),   .input_b_real12(input_b_real12_vmm1), 
.input_b_real13(input_b_real13_vmm1),   .input_b_real14(input_b_real14_vmm1),   .input_b_real15(input_b_real15_vmm1),   .input_b_real16(input_b_real16_vmm1),
.input_a_imag9(input_a_imag9_vmm1),     .input_a_imag10(input_a_imag10_vmm1),   .input_a_imag11(input_a_imag11_vmm1),   .input_a_imag12(input_a_imag12_vmm1), 
.input_a_imag13(input_a_imag13_vmm1),   .input_a_imag14(input_a_imag14_vmm1),   .input_a_imag15(input_a_imag15_vmm1),   .input_a_imag16(input_a_imag16_vmm1),
.input_b_imag9(input_b_imag9_vmm1),     .input_b_imag10(input_b_imag10_vmm1),   .input_b_imag11(input_b_imag11_vmm1),   .input_b_imag12(input_b_imag12_vmm1), 
.input_b_imag13(input_b_imag13_vmm1),   .input_b_imag14(input_b_imag14_vmm1),   .input_b_imag15(input_b_imag15_vmm1),   .input_b_imag16(input_b_imag16_vmm1),
.output_z_real1(output_z_real1_vmm1),   .output_z_real2(output_z_real2_vmm1),   .output_z_real3(output_z_real3_vmm1),   .output_z_real4(output_z_real4_vmm1), 
.output_z_real5(output_z_real5_vmm1),   .output_z_real6(output_z_real6_vmm1),   .output_z_real7(output_z_real7_vmm1),   .output_z_real8(output_z_real8_vmm1),
.output_z_imag1(output_z_imag1_vmm1),   .output_z_imag2(output_z_imag2_vmm1),   .output_z_imag3(output_z_imag3_vmm1),   .output_z_imag4(output_z_imag4_vmm1), 
.output_z_imag5(output_z_imag5_vmm1),   .output_z_imag6(output_z_imag6_vmm1),   .output_z_imag7(output_z_imag7_vmm1),   .output_z_imag8(output_z_imag8_vmm1),
.output_z_real9(output_z_real9_vmm1),   .output_z_real10(output_z_real10_vmm1), .output_z_real11(output_z_real11_vmm1), .output_z_real12(output_z_real12_vmm1), 
.output_z_real13(output_z_real13_vmm1), .output_z_real14(output_z_real14_vmm1), .output_z_real15(output_z_real15_vmm1), .output_z_real16(output_z_real16_vmm1),
.output_z_imag9 (output_z_imag9_vmm1),  .output_z_imag10(output_z_imag10_vmm1), .output_z_imag11(output_z_imag11_vmm1), .output_z_imag12(output_z_imag12_vmm1), 
.output_z_imag13(output_z_imag13_vmm1), .output_z_imag14(output_z_imag14_vmm1), .output_z_imag15(output_z_imag15_vmm1), .output_z_imag16(output_z_imag16_vmm1)
);



input [15:0] input_a_real1_vmm2, input_a_real2_vmm2,  input_a_real3_vmm2,  input_a_real4_vmm2,  input_a_real5_vmm2,  input_a_real6_vmm2,  input_a_real7_vmm2,  input_a_real8_vmm2;
input [15:0] input_a_imag1_vmm2, input_a_imag2_vmm2,  input_a_imag3_vmm2,  input_a_imag4_vmm2,  input_a_imag5_vmm2,  input_a_imag6_vmm2,  input_a_imag7_vmm2,  input_a_imag8_vmm2;
input [15:0] input_a_real9_vmm2, input_a_real10_vmm2, input_a_real11_vmm2, input_a_real12_vmm2, input_a_real13_vmm2, input_a_real14_vmm2, input_a_real15_vmm2, input_a_real16_vmm2;
input [15:0] input_a_imag9_vmm2, input_a_imag10_vmm2, input_a_imag11_vmm2, input_a_imag12_vmm2, input_a_imag13_vmm2, input_a_imag14_vmm2, input_a_imag15_vmm2, input_a_imag16_vmm2;
input [9:0]  input_b_real1_vmm2, input_b_real2_vmm2,   input_b_real3_vmm2,  input_b_real4_vmm2,  input_b_real5_vmm2,  input_b_real6_vmm2,  input_b_real7_vmm2,  input_b_real8_vmm2;
input [9:0]  input_b_imag1_vmm2, input_b_imag2_vmm2,   input_b_imag3_vmm2,  input_b_imag4_vmm2,  input_b_imag5_vmm2,  input_b_imag6_vmm2,  input_b_imag7_vmm2,  input_b_imag8_vmm2;
input [9:0]  input_b_real9_vmm2, input_b_real10_vmm2, input_b_real11_vmm2, input_b_real12_vmm2, input_b_real13_vmm2, input_b_real14_vmm2, input_b_real15_vmm2, input_b_real16_vmm2;
input [9:0]  input_b_imag9_vmm2, input_b_imag10_vmm2, input_b_imag11_vmm2, input_b_imag12_vmm2, input_b_imag13_vmm2, input_b_imag14_vmm2, input_b_imag15_vmm2, input_b_imag16_vmm2;
output [15:0] output_z_real1_vmm2, output_z_real2_vmm2,  output_z_real3_vmm2,  output_z_real4_vmm2,  output_z_real5_vmm2,  output_z_real6_vmm2,  output_z_real7_vmm2,  output_z_real8_vmm2;
output [15:0] output_z_imag1_vmm2, output_z_imag2_vmm2,  output_z_imag3_vmm2,  output_z_imag4_vmm2,  output_z_imag5_vmm2,  output_z_imag6_vmm2,  output_z_imag7_vmm2,  output_z_imag8_vmm2;
output [15:0] output_z_real9_vmm2, output_z_real10_vmm2, output_z_real11_vmm2, output_z_real12_vmm2, output_z_real13_vmm2, output_z_real14_vmm2, output_z_real15_vmm2, output_z_real16_vmm2;
output [15:0] output_z_imag9_vmm2, output_z_imag10_vmm2, output_z_imag11_vmm2, output_z_imag12_vmm2, output_z_imag13_vmm2, output_z_imag14_vmm2, output_z_imag15_vmm2, output_z_imag16_vmm2;

vmm_single VMM_SINGLE2(
.CLK(CLK), .rst(rst),
.input_a_real1(input_a_real1_vmm2),     .input_a_real2(input_a_real2_vmm2),     .input_a_real3(input_a_real3_vmm2),     .input_a_real4(input_a_real4_vmm2), 
.input_a_real5(input_a_real5_vmm2),     .input_a_real6(input_a_real6_vmm2),     .input_a_real7(input_a_real7_vmm2),     .input_a_real8(input_a_real8_vmm2),
.input_b_real1(input_b_real1_vmm2),     .input_b_real2(input_b_real2_vmm2),     .input_b_real3(input_b_real3_vmm2),     .input_b_real4(input_b_real4_vmm2), 
.input_b_real5(input_b_real5_vmm2),     .input_b_real6(input_b_real6_vmm2),     .input_b_real7(input_b_real7_vmm2),     .input_b_real8(input_b_real8_vmm2),
.input_a_imag1(input_a_imag1_vmm2),     .input_a_imag2(input_a_imag2_vmm2),     .input_a_imag3(input_a_imag3_vmm2),     .input_a_imag4(input_a_imag4_vmm2), 
.input_a_imag5(input_a_imag5_vmm2),     .input_a_imag6(input_a_imag6_vmm2),     .input_a_imag7(input_a_imag7_vmm2),     .input_a_imag8(input_a_imag8_vmm2),
.input_b_imag1(input_b_imag1_vmm2),     .input_b_imag2(input_b_imag2_vmm2),     .input_b_imag3(input_b_imag3_vmm2),     .input_b_imag4(input_b_imag4_vmm2), 
.input_b_imag5(input_b_imag5_vmm2),     .input_b_imag6(input_b_imag6_vmm2),     .input_b_imag7(input_b_imag7_vmm2),     .input_b_imag8(input_b_imag8_vmm2),
.input_a_real9(input_a_real9_vmm2),     .input_a_real10(input_a_real10_vmm2),   .input_a_real11(input_a_real11_vmm2),   .input_a_real12(input_a_real12_vmm2), 
.input_a_real13(input_a_real13_vmm2),   .input_a_real14(input_a_real14_vmm2),   .input_a_real15(input_a_real15_vmm2),   .input_a_real16(input_a_real16_vmm2),
.input_b_real9(input_b_real9_vmm2),     .input_b_real10(input_b_real10_vmm2),   .input_b_real11(input_b_real11_vmm2),   .input_b_real12(input_b_real12_vmm2), 
.input_b_real13(input_b_real13_vmm2),   .input_b_real14(input_b_real14_vmm2),   .input_b_real15(input_b_real15_vmm2),   .input_b_real16(input_b_real16_vmm2),
.input_a_imag9(input_a_imag9_vmm2),     .input_a_imag10(input_a_imag10_vmm2),   .input_a_imag11(input_a_imag11_vmm2),   .input_a_imag12(input_a_imag12_vmm2), 
.input_a_imag13(input_a_imag13_vmm2),   .input_a_imag14(input_a_imag14_vmm2),   .input_a_imag15(input_a_imag15_vmm2),   .input_a_imag16(input_a_imag16_vmm2),
.input_b_imag9(input_b_imag9_vmm2),     .input_b_imag10(input_b_imag10_vmm2),   .input_b_imag11(input_b_imag11_vmm2),   .input_b_imag12(input_b_imag12_vmm2), 
.input_b_imag13(input_b_imag13_vmm2),   .input_b_imag14(input_b_imag14_vmm2),   .input_b_imag15(input_b_imag15_vmm2),   .input_b_imag16(input_b_imag16_vmm2),
.output_z_real1(output_z_real1_vmm2),   .output_z_real2(output_z_real2_vmm2),   .output_z_real3(output_z_real3_vmm2),   .output_z_real4(output_z_real4_vmm2), 
.output_z_real5(output_z_real5_vmm2),   .output_z_real6(output_z_real6_vmm2),   .output_z_real7(output_z_real7_vmm2),   .output_z_real8(output_z_real8_vmm2),
.output_z_imag1(output_z_imag1_vmm2),   .output_z_imag2(output_z_imag2_vmm2),   .output_z_imag3(output_z_imag3_vmm2),   .output_z_imag4(output_z_imag4_vmm2), 
.output_z_imag5(output_z_imag5_vmm2),   .output_z_imag6(output_z_imag6_vmm2),   .output_z_imag7(output_z_imag7_vmm2),   .output_z_imag8(output_z_imag8_vmm2),
.output_z_real9(output_z_real9_vmm2),   .output_z_real10(output_z_real10_vmm2), .output_z_real11(output_z_real11_vmm2), .output_z_real12(output_z_real12_vmm2), 
.output_z_real13(output_z_real13_vmm2), .output_z_real14(output_z_real14_vmm2), .output_z_real15(output_z_real15_vmm2), .output_z_real16(output_z_real16_vmm2),
.output_z_imag9 (output_z_imag9_vmm2),  .output_z_imag10(output_z_imag10_vmm2), .output_z_imag11(output_z_imag11_vmm2), .output_z_imag12(output_z_imag12_vmm2), 
.output_z_imag13(output_z_imag13_vmm2), .output_z_imag14(output_z_imag14_vmm2), .output_z_imag15(output_z_imag15_vmm2), .output_z_imag16(output_z_imag16_vmm2)
);



input [15:0] input_a_real1_vmm3, input_a_real2_vmm3,  input_a_real3_vmm3,  input_a_real4_vmm3,  input_a_real5_vmm3,  input_a_real6_vmm3,  input_a_real7_vmm3,  input_a_real8_vmm3;
input [15:0] input_a_imag1_vmm3, input_a_imag2_vmm3,  input_a_imag3_vmm3,  input_a_imag4_vmm3,  input_a_imag5_vmm3,  input_a_imag6_vmm3,  input_a_imag7_vmm3,  input_a_imag8_vmm3;
input [15:0] input_a_real9_vmm3, input_a_real10_vmm3, input_a_real11_vmm3, input_a_real12_vmm3, input_a_real13_vmm3, input_a_real14_vmm3, input_a_real15_vmm3, input_a_real16_vmm3;
input [15:0] input_a_imag9_vmm3, input_a_imag10_vmm3, input_a_imag11_vmm3, input_a_imag12_vmm3, input_a_imag13_vmm3, input_a_imag14_vmm3, input_a_imag15_vmm3, input_a_imag16_vmm3;
input [9:0]  input_b_real1_vmm3, input_b_real2_vmm3,   input_b_real3_vmm3,  input_b_real4_vmm3,  input_b_real5_vmm3,  input_b_real6_vmm3,  input_b_real7_vmm3,  input_b_real8_vmm3;
input [9:0]  input_b_imag1_vmm3, input_b_imag2_vmm3,   input_b_imag3_vmm3,  input_b_imag4_vmm3,  input_b_imag5_vmm3,  input_b_imag6_vmm3,  input_b_imag7_vmm3,  input_b_imag8_vmm3;
input [9:0]  input_b_real9_vmm3, input_b_real10_vmm3, input_b_real11_vmm3, input_b_real12_vmm3, input_b_real13_vmm3, input_b_real14_vmm3, input_b_real15_vmm3, input_b_real16_vmm3;
input [9:0]  input_b_imag9_vmm3, input_b_imag10_vmm3, input_b_imag11_vmm3, input_b_imag12_vmm3, input_b_imag13_vmm3, input_b_imag14_vmm3, input_b_imag15_vmm3, input_b_imag16_vmm3;
output [15:0] output_z_real1_vmm3, output_z_real2_vmm3,  output_z_real3_vmm3,  output_z_real4_vmm3,  output_z_real5_vmm3,  output_z_real6_vmm3,  output_z_real7_vmm3,  output_z_real8_vmm3;
output [15:0] output_z_imag1_vmm3, output_z_imag2_vmm3,  output_z_imag3_vmm3,  output_z_imag4_vmm3,  output_z_imag5_vmm3,  output_z_imag6_vmm3,  output_z_imag7_vmm3,  output_z_imag8_vmm3;
output [15:0] output_z_real9_vmm3, output_z_real10_vmm3, output_z_real11_vmm3, output_z_real12_vmm3, output_z_real13_vmm3, output_z_real14_vmm3, output_z_real15_vmm3, output_z_real16_vmm3;
output [15:0] output_z_imag9_vmm3, output_z_imag10_vmm3, output_z_imag11_vmm3, output_z_imag12_vmm3, output_z_imag13_vmm3, output_z_imag14_vmm3, output_z_imag15_vmm3, output_z_imag16_vmm3;

vmm_single VMM_SINGLE3(
.CLK(CLK), .rst(rst),
.input_a_real1(input_a_real1_vmm3),     .input_a_real2(input_a_real2_vmm3),     .input_a_real3(input_a_real3_vmm3),     .input_a_real4(input_a_real4_vmm3), 
.input_a_real5(input_a_real5_vmm3),     .input_a_real6(input_a_real6_vmm3),     .input_a_real7(input_a_real7_vmm3),     .input_a_real8(input_a_real8_vmm3),
.input_b_real1(input_b_real1_vmm3),     .input_b_real2(input_b_real2_vmm3),     .input_b_real3(input_b_real3_vmm3),     .input_b_real4(input_b_real4_vmm3), 
.input_b_real5(input_b_real5_vmm3),     .input_b_real6(input_b_real6_vmm3),     .input_b_real7(input_b_real7_vmm3),     .input_b_real8(input_b_real8_vmm3),
.input_a_imag1(input_a_imag1_vmm3),     .input_a_imag2(input_a_imag2_vmm3),     .input_a_imag3(input_a_imag3_vmm3),     .input_a_imag4(input_a_imag4_vmm3), 
.input_a_imag5(input_a_imag5_vmm3),     .input_a_imag6(input_a_imag6_vmm3),     .input_a_imag7(input_a_imag7_vmm3),     .input_a_imag8(input_a_imag8_vmm3),
.input_b_imag1(input_b_imag1_vmm3),     .input_b_imag2(input_b_imag2_vmm3),     .input_b_imag3(input_b_imag3_vmm3),     .input_b_imag4(input_b_imag4_vmm3), 
.input_b_imag5(input_b_imag5_vmm3),     .input_b_imag6(input_b_imag6_vmm3),     .input_b_imag7(input_b_imag7_vmm3),     .input_b_imag8(input_b_imag8_vmm3),
.input_a_real9(input_a_real9_vmm3),     .input_a_real10(input_a_real10_vmm3),   .input_a_real11(input_a_real11_vmm3),   .input_a_real12(input_a_real12_vmm3), 
.input_a_real13(input_a_real13_vmm3),   .input_a_real14(input_a_real14_vmm3),   .input_a_real15(input_a_real15_vmm3),   .input_a_real16(input_a_real16_vmm3),
.input_b_real9(input_b_real9_vmm3),     .input_b_real10(input_b_real10_vmm3),   .input_b_real11(input_b_real11_vmm3),   .input_b_real12(input_b_real12_vmm3), 
.input_b_real13(input_b_real13_vmm3),   .input_b_real14(input_b_real14_vmm3),   .input_b_real15(input_b_real15_vmm3),   .input_b_real16(input_b_real16_vmm3),
.input_a_imag9(input_a_imag9_vmm3),     .input_a_imag10(input_a_imag10_vmm3),   .input_a_imag11(input_a_imag11_vmm3),   .input_a_imag12(input_a_imag12_vmm3), 
.input_a_imag13(input_a_imag13_vmm3),   .input_a_imag14(input_a_imag14_vmm3),   .input_a_imag15(input_a_imag15_vmm3),   .input_a_imag16(input_a_imag16_vmm3),
.input_b_imag9(input_b_imag9_vmm3),     .input_b_imag10(input_b_imag10_vmm3),   .input_b_imag11(input_b_imag11_vmm3),   .input_b_imag12(input_b_imag12_vmm3), 
.input_b_imag13(input_b_imag13_vmm3),   .input_b_imag14(input_b_imag14_vmm3),   .input_b_imag15(input_b_imag15_vmm3),   .input_b_imag16(input_b_imag16_vmm3),
.output_z_real1(output_z_real1_vmm3),   .output_z_real2(output_z_real2_vmm3),   .output_z_real3(output_z_real3_vmm3),   .output_z_real4(output_z_real4_vmm3), 
.output_z_real5(output_z_real5_vmm3),   .output_z_real6(output_z_real6_vmm3),   .output_z_real7(output_z_real7_vmm3),   .output_z_real8(output_z_real8_vmm3),
.output_z_imag1(output_z_imag1_vmm3),   .output_z_imag2(output_z_imag2_vmm3),   .output_z_imag3(output_z_imag3_vmm3),   .output_z_imag4(output_z_imag4_vmm3), 
.output_z_imag5(output_z_imag5_vmm3),   .output_z_imag6(output_z_imag6_vmm3),   .output_z_imag7(output_z_imag7_vmm3),   .output_z_imag8(output_z_imag8_vmm3),
.output_z_real9(output_z_real9_vmm3),   .output_z_real10(output_z_real10_vmm3), .output_z_real11(output_z_real11_vmm3), .output_z_real12(output_z_real12_vmm3), 
.output_z_real13(output_z_real13_vmm3), .output_z_real14(output_z_real14_vmm3), .output_z_real15(output_z_real15_vmm3), .output_z_real16(output_z_real16_vmm3),
.output_z_imag9 (output_z_imag9_vmm3),  .output_z_imag10(output_z_imag10_vmm3), .output_z_imag11(output_z_imag11_vmm3), .output_z_imag12(output_z_imag12_vmm3), 
.output_z_imag13(output_z_imag13_vmm3), .output_z_imag14(output_z_imag14_vmm3), .output_z_imag15(output_z_imag15_vmm3), .output_z_imag16(output_z_imag16_vmm3)
);






endmodule
