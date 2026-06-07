module rsadd (	saout, 
	//	a2, 
	//	a1, 
		r1out,
		r0out,
		a0, 
		rsfunc, 
	//	nx_rsfunc_rom0,
	//	nx_rsfunc_rom1,
	//	romsel,
		reset_l,
		eadd, 
		rsout, 
		rsovfi, 
		rsneg, 
		rs2zero, 
               	lsround, 
		b0, 
		b1, 
		clk, 
		sm, 
		sin,
		so, 
		incin, 
		stin, 
		rs32,
               	incinfunc, 
		rsovf, 
		erop,
		fpuhold 
		);

input  [4:0]  saout;
//input  [31:0] a1;
input  [31:0] a0;
input  [2:0]  incinfunc;
//input  [1:0]  romsel;
//input  [2:0]  rsfunc, nx_rsfunc_rom0, nx_rsfunc_rom1;
input  [31:0] r0out, r1out;
input  [2:0]  rsfunc;
input  [31:0] b1;
input  [31:0] b0;
input  reset_l, eadd, lsround, clk, sin, sm, rs32, erop,fpuhold;
output [31:0] rsout;
output        rsovfi, rsneg, rs2zero, incin, stin, rsovf;
output so;

wire          a0zero, aqcin, sticky;
wire   [1:0]  bsmd;
//wire   [1:0]  r0md, r1md;

 rsadd_dp p_rsadd_dp ( 		.a0zero(a0zero),
	                	.a0(a0),
                       	//	.a1(a1), 
                       	//	.r0md(r0md),
			//	.r1md(r0md),
                       	//	.a2(a2), 
				.r1out(r1out),
				.r0out(r0out),
                      		.stin(stin),
                      		.sticky(sticky),
                      		.saout(saout), 
                      		.b1(b1),
                      		.b0(b0),
                      		.bsmd(bsmd[1:0]), 
                      		.aqcin(aqcin), 
                      		.rsout(rsout), 
                      		.rsovfi(rsovfi)
                     		);

 rsadd_cntl p_rsadd_cntl ( 	
			//	.r0md(r0md), 
				.bsmd(bsmd[1:0]),
				.rsfunc(rsfunc),
			//	.nx_rsfunc_rom0(nx_rsfunc_rom0),
			//	.nx_rsfunc_rom1(nx_rsfunc_rom1),
			//	.romsel(romsel),
				.sticky(sticky),
				.a0zero(a0zero), 
				.rs32(rs32), 
				.out({incin, stin, rsovf}),
				.erop(erop),
			        .rsout_11_0(rsout[11:0]),
			        .incinfunc(incinfunc),
				.lsround(lsround),
				.rsovfi(rsovfi), 
				.clk(clk),
				.reset_l(reset_l),
				.aqcin(aqcin), 
				.rsout_31_30(rsout[31:30]),
				.rsneg(rsneg),
				.eadd(eadd), 
				.fpuhold(fpuhold),
				.rs2zero(rs2zero),
		 		.sm(),
				.sin(),
				.so() 
				);
endmodule
