module vmm_dcfir(
CLK, rst, 
ssb_coe, sdi_coe, 
ssb_vmm, sdi_vmm,
sel, CEB,
output_z_real_final_adder_level2,
output_z_imag_final_adder_level2
);

input  CLK, rst, ssb_coe, ssb_vmm;
input  [5:0]  sel;
input  [22:0] sdi_coe;
input  [23:0] sdi_vmm;
input  CEB;

wire [31:0] output_z_0, output_z_1, output_z_2, output_z_3;

top_combine VMM_TOP(
.CLK(CLK), .rst(rst),
.CEB(CEB), .ssb(ssb_vmm), 
.sdi(sdi_vmm),
.output_z_0(output_z_0), 
.output_z_1(output_z_1), 
.output_z_2(output_z_2), 
.output_z_3(output_z_3)
);

wire [15:0] output_real_dcfir0, output_img_dcfir0;
top_d_cfir DUT_DCFIR0(
.CLK(CLK), .rst(rst), .ssb(ssb_coe), .sdi(sdi_coe), .sel(sel),    
.din_data_real(output_z_0[31:16]), .din_data_imag(output_z_0[15:0]),  
.output_real(output_real_dcfir0), 
.output_img(output_img_dcfir0)      
);

wire [15:0] output_real_dcfir1, output_img_dcfir1;
top_d_cfir DUT_DCFIR1(
.CLK(CLK), .rst(rst), .ssb(ssb_coe), .sdi(sdi_coe), .sel(sel),    
.din_data_real(output_z_1[31:16]), .din_data_imag(output_z_1[15:0]),  
.output_real(output_real_dcfir1), 
.output_img(output_img_dcfir1)      
);

wire [15:0] output_real_dcfir2, output_img_dcfir2;
top_d_cfir DUT_DCFIR2(
.CLK(CLK), .rst(rst), .ssb(ssb_coe), .sdi(sdi_coe), .sel(sel),    
.din_data_real(output_z_2[31:16]), .din_data_imag(output_z_2[15:0]),  
.output_real(output_real_dcfir2), 
.output_img(output_img_dcfir2)      
);

wire [15:0] output_real_dcfir3, output_img_dcfir3;
top_d_cfir DUT_DCFIR3(
.CLK(CLK), .rst(rst), .ssb(ssb_coe), .sdi(sdi_coe), .sel(sel),    
.din_data_real(output_z_3[31:16]), .din_data_imag(output_z_3[15:0]),  
.output_real(output_real_dcfir3), 
.output_img(output_img_dcfir3)      
);

wire [15:0] output_z_real_final_adder_level1_0;
wire [15:0] output_z_imag_final_adder_level1_0;

complex_adder DUT_FINAL_ADDER_level1_0(
.CLK(CLK), .rst(rst), 
.input_a_real(output_real_dcfir0),.input_b_real(output_real_dcfir1),
.input_a_imag(output_img_dcfir0),.input_b_imag(output_img_dcfir1),
.output_z_real(output_z_real_final_adder_level1_0),
.output_z_imag(output_z_imag_final_adder_level1_0)
);


wire [15:0] output_z_real_final_adder_level1_1;
wire [15:0] output_z_imag_final_adder_level1_1;

complex_adder DUT_FINAL_ADDER_level1_1(
.CLK(CLK), .rst(rst), 
.input_a_real(output_real_dcfir2),.input_b_real(output_real_dcfir3),
.input_a_imag(output_img_dcfir2),.input_b_imag(output_img_dcfir3),
.output_z_real(output_z_real_final_adder_level1_1),
.output_z_imag(output_z_imag_final_adder_level1_1)
);

output [15:0] output_z_real_final_adder_level2;
output [15:0] output_z_imag_final_adder_level2;

complex_adder DUT_FINAL_ADDER_level2(
.CLK(CLK), .rst(rst), 
.input_a_real(output_z_real_final_adder_level1_0),.input_b_real(output_z_real_final_adder_level1_1),
.input_a_imag(output_z_imag_final_adder_level1_0),.input_b_imag(output_z_imag_final_adder_level1_1),
.output_z_real(output_z_real_final_adder_level2),
.output_z_imag(output_z_imag_final_adder_level2)
);

endmodule
