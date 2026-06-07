module valid_dec (

	input	[6:0]	fetch_valid,
	input	[7:0]	accum_len0,
	input	[7:0]	accum_len1,
	input	[7:0]	accum_len2,
	input	[5:0]	ex_len_first_inst,
	input	[3:0]	fetch_len1,
	input	[3:0]	fetch_len2,
	input	[3:0]	fetch_len3,
	input	[3:0]	fetch_len4,
	input	[3:0]	fetch_len5,
	input	[3:0]	fetch_len6,
	output	[3:0]	dec_valid
);

wire	vld_1_len1, vld_1_len2, vld_1_len3;
wire	vld_2_len1, vld_2_len2, vld_2_len3;
wire	vld_3_len1, vld_3_len2, vld_3_len3;
wire	vld_4_len1, vld_4_len2, vld_4_len3;
wire	vld_5_len1, vld_5_len2, vld_5_len3;
wire	vld_6_len1, vld_6_len2, vld_6_len3;

wire	vld_0, vld_1, vld_2, vld_3, vld_4, vld_5, vld_6;

assign	vld_1_len1 = fetch_valid[1];
assign	vld_1_len2 = &(fetch_valid[2:1]);
assign	vld_1_len3 = &(fetch_valid[3:1]);

assign	vld_2_len1 = fetch_valid[2];
assign	vld_2_len2 = &(fetch_valid[3:2]);
assign	vld_2_len3 = &(fetch_valid[4:2]);

assign	vld_3_len1 = fetch_valid[3];
assign	vld_3_len2 = &(fetch_valid[4:3]);
assign	vld_3_len3 = &(fetch_valid[5:3]);

assign	vld_4_len1 = fetch_valid[4];
assign	vld_4_len2 = &(fetch_valid[5:4]);
assign	vld_4_len3 = &(fetch_valid[6:4]);

assign	vld_5_len1 = fetch_valid[5];
assign	vld_5_len2 = &(fetch_valid[6:5]);
assign	vld_5_len3 = 1'b0;

assign	vld_6_len1 = fetch_valid[6];
assign	vld_6_len2 = 1'b0;
assign	vld_6_len3 = 1'b0;

// Determine for each of the bytes in the ibuffer, what would be the valids
// depending on their lengths

assign	vld_0 = |(ex_len_first_inst[5:1]);

mux4	mux_vld_1_byte (.out(vld_1),
			.in0(1'b0),
			.in1(vld_1_len1),
			.in2(vld_1_len2),
			.in3(vld_1_len3),
			.sel(fetch_len1) );

mux4	mux_vld_2_byte (.out(vld_2),
			.in0(1'b0),
			.in1(vld_2_len1),
			.in2(vld_2_len2),
			.in3(vld_2_len3),
			.sel(fetch_len2) );

mux4	mux_vld_3_byte (.out(vld_3),
			.in0(1'b0),
			.in1(vld_3_len1),
			.in2(vld_3_len2),
			.in3(vld_3_len3),
			.sel(fetch_len3) );

mux4	mux_vld_4_byte (.out(vld_4),
			.in0(1'b0),
			.in1(vld_4_len1),
			.in2(vld_4_len2),
			.in3(vld_4_len3),
			.sel(fetch_len4) );

mux4	mux_vld_5_byte (.out(vld_5),
			.in0(1'b0),
			.in1(vld_5_len1),
			.in2(vld_5_len2),
			.in3(vld_5_len3),
			.sel(fetch_len5) );

mux4	mux_vld_6_byte (.out(vld_6),
			.in0(1'b0),
			.in1(vld_6_len1),
			.in2(vld_6_len2),
			.in3(vld_6_len3),
			.sel(fetch_len6) );

// Now determine the valids of the four prospcetive instructions to be folded

assign	dec_valid[0] = vld_0;

mux8	mux_vld_1_inst (.out(dec_valid[1]),
			.in0(1'b0),
			.in1(vld_1),
			.in2(vld_2),
			.in3(vld_3),
			.in4(vld_4),
			.in5(vld_5),
			.in6(vld_6),
			.in7(1'b0),
			.sel(accum_len0) );

mux8	mux_vld_2_inst (.out(dec_valid[2]),
			.in0(1'b0),
			.in1(vld_1),
			.in2(vld_2),
			.in3(vld_3),
			.in4(vld_4),
			.in5(vld_5),
			.in6(vld_6),
			.in7(1'b0),
			.sel(accum_len1) );

mux8	mux_vld_3_inst (.out(dec_valid[3]),
			.in0(1'b0),
			.in1(vld_1),
			.in2(vld_2),
			.in3(vld_3),
			.in4(vld_4),
			.in5(vld_5),
			.in6(vld_6),
			.in7(1'b0),
			.sel(accum_len2) );

endmodule
