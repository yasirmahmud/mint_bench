module prils_cntl (lsdprec,m1c,m3c,m0c,m4,m2c,prifunc,incinfunc,
		   nx_prifunc_rom0,nx_prifunc_rom1,romsel,clk,reset_l, fpuhold, sm, sin, so);

output    [1:0]  m1c,m2c,m3c;
output    lsdprec,m0c, m4;
output so;
input sm, sin;
input     [2:0]  prifunc,incinfunc,nx_prifunc_rom0,nx_prifunc_rom1;
input		 clk, reset_l, fpuhold;
input [1:0] romsel;

pri_dec prid(	.m0(m0c),
		.m1(m1c),
		.m2(m2c),
		.m3(m3c),
		.m4(m4),
		.prifunc(prifunc),
		.nx_prifunc_rom0(nx_prifunc_rom0),
		.nx_prifunc_rom1(nx_prifunc_rom1),
		.romsel(romsel),
		.clk(clk),
		.fpuhold(fpuhold),
		.reset_l(reset_l),
		.so(so),
		.sin(sin),
		.sm(sm));

assign lsdprec = (incinfunc==3'h5);

endmodule
