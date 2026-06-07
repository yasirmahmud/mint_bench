module exponent_cntl(priout_l, topsign, le, morethree, 
		     rs32, rsge64, fmulovf, aexpout, saout,
		     addtcin, addlcin, mux1ad, mux2ad, muxbed,
		     muxlimd, muxsad_a, muxsad_b, muxaed, 
		     aexp_sel, bexp_sel, muxpaed_a, fpuhold,
		     mux2bd, expfunc, safunc, movf, clk, reset_l,
		     dprec, cyc0_type, erop, nx_expfunc_rom0, nx_expfunc_rom1,
		     priout, sa, addtop, addlow, muxpaed_b, muxpaed_c,
		     bele, aele, azle, bzle, aexp, bexp, or_out, romsel,sm, sin, so);

input	[3:0]	expfunc, nx_expfunc_rom0, nx_expfunc_rom1;
input	[2:0]	safunc;
input	[1:0]   romsel;
input	[2:0]	cyc0_type;
input	[5:0]	priout;
input		movf, dprec, erop, clk, reset_l, fpuhold;
input	[15:0]	sa, aexp, bexp, addtop, addlow;
input		aele, bele, azle, bzle, topsign;
input		sm,sin;

output		so;
output		le, morethree, rs32, rsge64, fmulovf,
		addtcin, addlcin, muxbed, or_out;
output	[10:0]	aexpout;
output	[4:0]	saout;
output	[5:0]	priout_l;
output	[1:0]	mux1ad, mux2ad;
output	[1:0]	aexp_sel, bexp_sel, muxaed, muxpaed_a, muxpaed_b, 
		muxpaed_c, muxsad_a, muxsad_b;
output	[1:0]	muxlimd, mux2bd;


wire	[5:0]	priout_l;
wire	[10:0]	aexpout;
wire		or_out_top, or_out_low;

wire    fpuhold_l = ~fpuhold;
assign priout_l = ~priout;

//*****************************************************************************
// Do the exponent decode section (synthesis)***********************************


 exptop_dec exptop(	.mux1ad(mux1ad),
			.mux2ad(mux2ad),
			.mux2bd(mux2bd),
                   	.addtcin(addtcin),
			.addlcin(addlcin),
			.ef(expfunc),
			.ef_rom0(nx_expfunc_rom0),
			.ef_rom1(nx_expfunc_rom1),
			.romsel(romsel),
			.clk(clk),
			.reset_l(reset_l),
			.fpuhold_l(fpuhold_l),
			.saf(safunc),
			.sm(),
			.sin(),
			.so());

 expbot_dec expbot(	
	//		.or_out_top(or_out_top),    
	//		.or_out_low(or_out_low),   
			.muxlimd(muxlimd),
			.muxsad_a(muxsad_a),
			.muxsad_b(muxsad_b),
			.muxpaed_a(muxpaed_a),
			.muxpaed_b(muxpaed_b),
			.muxpaed_c(muxpaed_c),
                	.muxbed(muxbed),
			.muxaed(muxaed),
			.ef(expfunc),
			.safunc(safunc),
                	.topsign(topsign),
			.movf(movf),
	//		.eadd(eadd),		
	//		.rsovf(rsovf),		
        //        	.amsb(amsb),		
			.erop(erop));

 exple_dec expcomp(	.le(le),
			.topsign(topsign),
			.bele(bele),
			.aele(aele),
			.azle(azle),
                     	.bzle(bzle),
			.expfunc(expfunc));

 expreg_dec expreg(	.cyc0_type(cyc0_type),
			.aexp_sel(aexp_sel),
                  	.bexp_sel(bexp_sel));

 assign rsge64 = (| sa[15:6]);
 assign rs32   = (rsge64 || sa[5]);
 assign fmulovf = (aexp >= 16'h170) || (aexp < 16'h80);
 
 assign or_out_top = (| addtop[15:6]) || (~dprec && addtop[5]);
 assign or_out_low = (| addlow[15:6]) || (~dprec && addlow[5]);

wire or_out = (topsign) ? or_out_low : or_out_top;

//************************end decode section of exponent******************
//************************************************************************

// First do the EXponent CONstant calculation.  These are 16-bit
// constants used in the exponent calculation.

 assign saout       = sa[4:0];
 assign aexpout     = aexp[10:0];

 assign morethree = ((& aexp[7:3]) || (& bexp[7:3]) || ~(| aexp[7:6])
                    || ~(| bexp[7:6]));

endmodule
