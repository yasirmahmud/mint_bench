// Original dcfir_vmm2 module
module dcfir_vmm2(
CLK, rst, sel,    
din_data_real, din_data_imag, //32bits
coe_real1, coe_real2, coe_real3,
coe_imag1, coe_imag2, coe_imag3,
output_real, output_img       //32bits
);

input CLK, rst; 

input [15:0] din_data_real;
wire [15:0] real_q1, real_q2, real_q3, real_q4, real_q5, real_q6, real_q7, real_q8, real_q9, real_q10, real_q11, real_q12, real_q13, real_q14, real_q15, real_q16; 
wire [15:0] real_q17, real_q18, real_q19, real_q20, real_q21, real_q22, real_q23, real_q24, real_q25, real_q26, real_q27, real_q28, real_q29, real_q30, real_q31, real_q32;


shift_register_32_stages SR(
.CLK(CLK),.din(din_data_real),.rst(rst),
.Q1(real_q1), .Q2(real_q2), .Q3(real_q3), .Q4(real_q4), 
.Q5(real_q5), .Q6(real_q6), .Q7(real_q7), .Q8(real_q8), 
.Q9(real_q9), .Q10(real_q10), .Q11(real_q11), .Q12(real_q12), 
.Q13(real_q13), .Q14(real_q14), .Q15(real_q15), .Q16(real_q16), 
.Q17(real_q17), .Q18(real_q18), .Q19(real_q19), .Q20(real_q20), 
.Q21(real_q21), .Q22(real_q22), .Q23(real_q23), .Q24(real_q24), 
.Q25(real_q25), .Q26(real_q26), .Q27(real_q27), .Q28(real_q28), 
.Q29(real_q29), .Q30(real_q30), .Q31(real_q31), .Q32(real_q32));

input [15:0] din_data_imag;
wire [15:0] imag_q1, imag_q2, imag_q3, imag_q4, imag_q5, imag_q6, imag_q7, imag_q8, imag_q9, imag_q10, imag_q11, imag_q12, imag_q13, imag_q14, imag_q15, imag_q16; 
wire [15:0] imag_q17, imag_q18, imag_q19, imag_q20, imag_q21, imag_q22, imag_q23, imag_q24, imag_q25, imag_q26, imag_q27, imag_q28, imag_q29, imag_q30, imag_q31, imag_q32;


shift_register_32_stages IR(
.CLK(CLK),.din(din_data_imag),.rst(rst),
.Q1(imag_q1), .Q2(imag_q2), .Q3(imag_q3), .Q4(imag_q4), 
.Q5(imag_q5), .Q6(imag_q6), .Q7(imag_q7), .Q8(imag_q8), 
.Q9(imag_q9), .Q10(imag_q10), .Q11(imag_q11), .Q12(imag_q12), 
.Q13(imag_q13), .Q14(imag_q14), .Q15(imag_q15), .Q16(imag_q16), 
.Q17(imag_q17), .Q18(imag_q18), .Q19(imag_q19), .Q20(imag_q20), 
.Q21(imag_q21), .Q22(imag_q22), .Q23(imag_q23), .Q24(imag_q24), 
.Q25(imag_q25), .Q26(imag_q26), .Q27(imag_q27), .Q28(imag_q28), 
.Q29(imag_q29), .Q30(imag_q30), .Q31(imag_q31), .Q32(imag_q32));

wire [15:0] real_mux_out;
input [5:0] sel;

mux_32_to_1 MUX_REAL(
.clk(CLK),
.din_0(real_q1), .din_1(real_q2), .din_2(real_q3), .din_3(real_q4),
.din_4(real_q5), .din_5(real_q6), .din_6(real_q7), .din_7(real_q8),
.din_8(real_q9), .din_9(real_q10), .din_10(real_q11), .din_11(real_q12),
.din_12(real_q13), .din_13(real_q14), .din_14(real_q15), .din_15(real_q16),
.din_16(real_q17), .din_17(real_q15), .din_18(real_q19), .din_19(real_q20),
.din_20(real_q21), .din_21(real_q22), .din_22(real_q23), .din_23(real_q24),
.din_24(real_q25), .din_25(real_q26), .din_26(real_q27), .din_27(real_q25),
.din_28(real_q29), .din_29(real_q30), .din_30(real_q31), .din_31(real_q32),
.sel(sel),
.mux_out(real_mux_out)
);

wire [15:0] imag_mux_out;

mux_32_to_1 MUX_IMAG(
.clk(CLK),
.din_0(imag_q1), .din_1(imag_q2), .din_2(imag_q3), .din_3(imag_q4),
.din_4(imag_q5), .din_5(imag_q6), .din_6(imag_q7), .din_7(imag_q8),
.din_8(imag_q9), .din_9(imag_q10), .din_10(imag_q11), .din_11(imag_q12),
.din_12(imag_q13), .din_13(imag_q14), .din_14(imag_q15), .din_15(imag_q16),
.din_16(imag_q17), .din_17(imag_q15), .din_18(imag_q19), .din_19(imag_q20),
.din_20(imag_q21), .din_21(imag_q22), .din_22(imag_q23), .din_23(imag_q24),
.din_24(imag_q25), .din_25(imag_q26), .din_26(imag_q27), .din_27(imag_q25),
.din_28(imag_q29), .din_29(imag_q30), .din_30(imag_q31), .din_31(imag_q32),
.sel(sel),
.mux_out(imag_mux_out)
);


input [9:0] coe_real1, coe_real2, coe_real3;
input [9:0] coe_imag1, coe_imag2, coe_imag3;


reg [9:0] coe_real1_buf, coe_real2_buf, coe_real3_buf; 
reg [9:0] coe_imag1_buf, coe_imag2_buf, coe_imag3_buf; 
wire [9:0] coe_real4_buf,coe_imag4_buf;
always @(posedge CLK) begin
    if (rst) begin
        coe_real1_buf <= 10'd0; 
        coe_real2_buf <= 10'd0; 
        coe_real3_buf <= 10'd0; 
        coe_imag1_buf <= 10'd0;
        coe_imag2_buf <= 10'd0;
        coe_imag3_buf <= 10'd0;
    end
    else begin
        coe_real1_buf <= coe_real1; 
        coe_real2_buf <= coe_real2; 
        coe_real3_buf <= coe_real3; 
        coe_imag1_buf <= coe_imag1;
        coe_imag2_buf <= coe_imag2;
        coe_imag3_buf <= coe_imag3;
  
    end
end

wire [15:0] data_real1, data_real2, data_real3, data_real4;
shift_register_16bit_4_stages DATA_SR_REAL(
.CLK(CLK),
.din(real_mux_out), 
.Q1(data_real1), .Q2(data_real2), .Q3(data_real3), .Q4(data_real4),
.Reset(rst)
);

wire [15:0] data_imag1, data_imag2, data_imag3, data_imag4;
shift_register_16bit_4_stages DATA_SR_IMAG(
.CLK(CLK),
.din(imag_mux_out), 
.Q1(data_imag1), .Q2(data_imag2), .Q3(data_imag3), .Q4(data_imag4),
.Reset(rst)
);

reg [15:0] data_real1_buf, data_real2_buf, data_real3_buf, data_real4_buf;
reg [15:0] data_imag1_buf, data_imag2_buf, data_imag3_buf, data_imag4_buf;
always @(posedge CLK) begin
    if (rst) begin
        data_real1_buf <= 16'd0; 
        data_real2_buf <= 16'd0; 
        data_real3_buf <= 16'd0; 
        data_real4_buf <= 16'd0;
        data_imag1_buf <= 16'd0;
        data_imag2_buf <= 16'd0;
        data_imag3_buf <= 16'd0;
        data_imag4_buf <= 16'd0;
    end
    else begin
        data_real1_buf <= data_real1; 
        data_real2_buf <= data_real2; 
        data_real3_buf <= data_real3; 
        data_real4_buf <= data_real4;
        data_imag1_buf <= data_imag1;
        data_imag2_buf <= data_imag2;
        data_imag3_buf <= data_imag3;
        data_imag4_buf <= data_imag4;   
    end
end

output [15:0] output_real, output_img;

wire flag;
assign flag = |data_real4;
wire [19:0] interp_mem;
reg [9:0] Addr;
always @(posedge CLK) begin
  if (~flag) begin
    Addr <= 10'd0;
  end else begin
    Addr <= Addr + 10'd1;
  end
end

interp_rom_1 INTERP_COE(
    .CLK(CLK), .rst(rst),
    .CEB(flag),
    .Addr(Addr),
    .Q(interp_mem));

assign {coe_real4_buf,coe_imag4_buf} = interp_mem;
interpolation_filter INTERP(
.multi1_a(data_real1_buf), .multi2_a(data_real2_buf), .multi3_a(data_real3_buf), .multi4_a(data_real4_buf),
.multi5_a(data_imag1_buf), .multi6_a(data_imag2_buf), .multi7_a(data_imag3_buf), .multi8_a(data_imag4_buf),
.multi1_b(coe_real1_buf), .multi2_b(coe_real2_buf), .multi3_b(coe_real3_buf), .multi4_b(coe_real4_buf),
.multi5_b(coe_imag1_buf), .multi6_b(coe_imag2_buf), .multi7_b(coe_imag3_buf), .multi8_b(coe_imag4_buf),
.CLK(CLK),.rst(rst),
.output_real(output_real),
.output_img(output_img)
);

endmodule
