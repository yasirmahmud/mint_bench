module rsadd_cntl (	
//			r0md, 
			bsmd, 
			rsfunc, 
//			romsel,
//			nx_rsfunc_rom0,
//			nx_rsfunc_rom1,
			sticky, 
			a0zero, 
			rs32, 
			out, 
                    	erop, 
			rsout_11_0, 
			incinfunc, 
			lsround, 
			rsovfi,
                    	clk, 
			aqcin, 
			rsout_31_30, 
			rsneg, 
			eadd, 
			rs2zero,
			reset_l,
			fpuhold ,
			sm, 
			sin,
			so
			);

  input    [2:0]   rsfunc;
//  input    [2:0]   nx_rsfunc_rom0, nx_rsfunc_rom1;
  input    [2:0]   incinfunc;
  input  [31:30]   rsout_31_30;
  input   [11:0]   rsout_11_0;
  input   sticky, a0zero, rs32, erop, lsround, rsovfi, eadd, clk, reset_l, fpuhold;
//  input  [1:0]	   romsel; 
//  output   [1:0]   r0md;
  output   [2:0]   out;
  output   [1:0]   bsmd;
  output           aqcin, rsneg, rs2zero;

input sm, sin;
output so;

  wire             acin, nextstin, rsround, incdprec, nxincin;


wire fpuhold_l = ~fpuhold;
 
  rsadd_dec rsadec ( 	
			.bsmd(bsmd),
			.acin(acin), 
			.rsfunc(rsfunc),
			.nextstin(nextstin),
			.nxstin(sticky),
			.a0zero(a0zero),
			.rs32(rs32),
			.stin(out[1]),
			.erop(erop), 
		 	.sm(),
			.sin(),
			.so()
			);

  round_dec rs2 ( 	.roundout(rsround),
			.in(rsout_11_0[11:0]),
			.prec(incdprec), 
        		.gin(1'b0),
			.stin(sticky) 
			);

  incin_dec id0 ( 	.nxincin(nxincin), 
			.incinfunc(incinfunc), 
			.lsround(lsround), 
			.rsround(rsround), 
			.incin(out[2]) 
			);


 mj_s_ff_snre_d_3 ff( 	.out(out), 
			.din({nxincin, nextstin, rsovfi}), 
			.lenable(fpuhold_l),
			.reset_l(reset_l), 
			.clk(clk));




  assign incdprec = (incinfunc==3'h3);
  assign aqcin = (acin & out[0]);
  assign rsneg = ~(rsovfi & ~eadd);
  assign rs2zero = (!eadd && !(| rsout_31_30[31:30]));

endmodule
