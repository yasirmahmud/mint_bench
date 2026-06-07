module ibuf_slice (
	icache_data,
	icache_data_sel,
	shft_data,
        shft_oplen,
	shft_data_sel,
	ibuf_dout,
	encode_oplen,
        ibuf_oplen,
	ibuf_en,
	buf_ic_sel,
	buf_ic_dout,
	buf_ic_oplen,
	clk,
	sin,
	sm,
	so
);

input	[63:0]	icache_data;		// Data from Icache after aligned properly 	-- From Aligner
input	[7:0]	icache_data_sel;	// These selects will determine which of the 	-- From ibuf_ctl
					// eight bytes from icache will be selected	  
input	[55:0]	shft_data;		// Data from the following 7 Buffer locations	-- From ibuf
input	[27:0]	shft_oplen;		// opcode length from the following 7 Buffer locations	-- From ibuf
input   [7:0]	shft_data_sel;		// These selects will determine which of the 	-- From ibuf_ctl
					// following 5 bytes will be selected
output	[7:0]	ibuf_dout;		// Data going out from ibuffer			-- To iu
input   [31:0]	encode_oplen;
input		buf_ic_sel;		// Tells whether the current Ibuffer entry os valid or not
output	[3:0]	ibuf_oplen;		// opcode length going out from ibuffer		-- To iu
output	[7:0]	buf_ic_dout;		// Curent ibuffer or icache data out
output  [3:0]	buf_ic_oplen;		// Current Ibuffer or icache opcode lengths
input		clk;			// Clk
input		sin;			// Scan data input
input		sm;			// Scan Enable input
output		so;			// Scan data output
input		ibuf_en;		// ibuffer clock enable


wire	[7:0] 	icache_mux_out;
wire 	[7:0]	ic_fill_mux_out;
wire    [3:0]	oplen_mux_out;
wire    [3:0]	oplen_fill_mux_out;

// Wire for connecting scan chain between flops
wire data_flop_so;


//  This mux will determine which of the 8 bytes coming from Aligner(Icache)
//  is choosen to reside in this particular ibuffer location

mux8_8 i_ic_mux (	.out(icache_mux_out),
                        .in7(icache_data[7:0]),
                        .in6(icache_data[15:8]),
                        .in5(icache_data[23:16]),
                        .in4(icache_data[31:24]),
                        .in3(icache_data[39:32]),
                        .in2(icache_data[47:40]),
                        .in1(icache_data[55:48]),
                        .in0(icache_data[63:56]),
                        .sel(icache_data_sel));

//  This mux will determine which of the 8 4-bit lengths coming from 
// len dec.s is choosen to reside in this particular ibuffer location

mux8_4 i_oplen_mux (       .out(oplen_mux_out),
                           .in7(encode_oplen[3:0]),
                           .in6(encode_oplen[7:4]),
                           .in5(encode_oplen[11:8]),
                           .in4(encode_oplen[15:12]),
                           .in3(encode_oplen[19:16]),
                           .in2(encode_oplen[23:20]),
                           .in1(encode_oplen[27:24]),
                           .in0(encode_oplen[31:28]),
                           .sel(icache_data_sel));


// This mux will determine whether the data from current ibuffer or icache 
// data is selected

mux2_8 ic_fill_mux (	.out(buf_ic_dout),
                        	.sel({buf_ic_sel,!buf_ic_sel}),
	                        .in0({icache_mux_out}),
	                        .in1({ibuf_dout})
	                        );

mux2_4 i_oplen_fill_mux (	.out(buf_ic_oplen),
                        	.sel({buf_ic_sel,!buf_ic_sel}),
                        	.in0({oplen_mux_out}),
                        	.in1({ibuf_oplen})
                        	);

// select the appr. data out and oplen
mux8_8 i_shft_mux (	.out(ic_fill_mux_out),
	                        .in7(shft_data[55:48]),
	                        .in6(shft_data[47:40]),
	                        .in5(shft_data[39:32]),
	                        .in4(shft_data[31:24]),
	                        .in3(shft_data[23:16]),
	                        .in2(shft_data[15:8]),
	                        .in1(shft_data[7:0]),
	                        .in0(buf_ic_dout),
	                        .sel(shft_data_sel));

mux8_4 i_shft_oplen_mux (  .out(oplen_fill_mux_out),
                                .in7(shft_oplen[27:24]),
                                .in6(shft_oplen[23:20]),
                                .in5(shft_oplen[19:16]),
                                .in4(shft_oplen[15:12]),
                                .in3(shft_oplen[11:8]),
                                .in2(shft_oplen[7:4]),
                                .in1(shft_oplen[3:0]),
                                .in0(buf_ic_oplen),
                                .sel(shft_data_sel));
//  Ibuffer flop

mj_s_ff_se_d_8 ibuf_data_flop ( .out(ibuf_dout),
				.din(ic_fill_mux_out),
				.lenable(ibuf_en),
				.clk(clk),
                                .sin(sin),
                                .sm(sm),
                                .so(data_flop_so)
				);

mj_s_ff_se_d_4 ibuf_len_flop ( .out(ibuf_oplen),
				.din(oplen_fill_mux_out),
				.lenable(ibuf_en),
				.clk(clk),
                                .sin(data_flop_so),
                                .sm(sm),
                                .so(so)
				);
endmodule
