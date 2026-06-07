module mult_add(eci, dpmul,hi_add,cinlo,cinhi,sinlo,sinhi,sti,multout,movf,
		aci,mout_sel, clk, reset_l, fpuhold_l);

  input  [27:0]  sinlo,sinhi;
  input  [26:0]  cinlo,cinhi;
  input  [1:0]   mout_sel;
  input          dpmul,sti,aci, eci, hi_add;
  input          clk, reset_l, fpuhold_l;
  output [31:0]  multout;
  output         movf;

  wire   [27:0]  caddout,saddout,cadd,addout;
  wire   [23:0]  sp_out;
  wire   [22:0]  fadd;
  wire   [3:0]   multhold,por;
  wire   [1:0]   spmd, mout_dr;
  wire           saddtop,carry_in,iovf,lin,ctop,aovf,laovf;
  wire  [27:0]  newsinhi;
  wire  [27:0]  sinhiout;
	
// added new sinhi logic for new mult_array 
// using fa28 to add one 28-bit to one 1-bit
//	since this is not timing critical.
//	if it becomes critial, we can optimize this.

  cla_adder_28 inc_sinhi (      .in1(sinhi),
				.in2(28'b0),
				.cin(eci),
				.cout(),
				.sum(sinhiout)
				);


mj_s_ff_snre_d_28 ffincsin(.out(newsinhi),
			.din(sinhiout),
			.lenable(fpuhold_l),
			.reset_l(reset_l),
			.clk(clk));


mj_s_mux2_d cadd27mux  (.mx_out(cadd[27]), 
			.in1(1'b0), 
			.in0(cinlo[26]), 
			.sel(dpmul) );

mj_s_mux2_d_4 pormux(.mx_out(por),
			.sel(dpmul),
			.in0({3'h0,sti}),
			.in1(multhold));

  assign cadd[26:0] = {cinlo[25:0],aci};
  assign laovf      = addout[27];
 
  assign saddtop = !dpmul & sinlo[27];


wire [3:0] caddmux_temp;
wire [3:0] saddmux_temp;
mj_s_mux2_d_32 caddmux(	.mx_out({caddmux_temp,caddout}),
			.sel(hi_add),
			.in0({4'b0,cadd}),
			.in1({4'b0,cinhi[26:0],ctop}));
mj_s_mux2_d_32 saddmux(	.mx_out({saddmux_temp,saddout}),
			.sel(hi_add),
			.in0({4'b0,saddtop,sinlo[26:0]}),
			.in1({4'b0,newsinhi}));
mj_s_mux2_d     carry(	.mx_out(carry_in),
			.sel(hi_add),
			.in0(1'h0),
			.in1(aovf));

mj_s_ff_snre_d_6 muhold (.out({aovf,ctop,multhold}),
			.din({laovf,cinlo[26], addout[26:23]}),
			.lenable(fpuhold_l),
			.reset_l(reset_l),
			.clk(clk));

 
  cla_adder_28   add28(	.sum(addout),
			.in1(caddout),
			.in2(saddout),
			.cin(carry_in),
			.cout());
 
/************************************************
*** replace with new adder, inc23 combination     
***         see module mult_addinc below.
  increment_23  inc23(	.cout(iovf),
			.sum(fadd),
			.in(addout[26:4]));
************************************************/
  mult_addinc addinc_0 (.fadd(fadd),
			.iovf(iovf),
			.in0(caddout),
			.in1(saddout),
			.cin(carry_in));


  mj_s_mux4_d_16 spmux_23_8  (.mx_out(sp_out[23:8]),
			.sel(spmd),
			.in0({1'h1,fadd[22:8]}),
			.in1({1'h1,addout[26:12]}),
                	.in2(addout[26:11]),
			.in3(fadd[22:7])); 
  mj_s_mux4_d_8 spmux_7_0  (.mx_out(sp_out[7:0]),
			.sel(spmd),
			.in0(fadd[7:0]),
			.in1(addout[11:4]),
                	.in2({addout[10:4],lin}),
			.in3({fadd[6:0],lin})); 

mj_s_mux4_d_32 moutmux(.mx_out(multout),
			.sel(mout_dr),
			.in0({sp_out,8'h0}),
			.in1({addout,por}),
                  	.in2({addout[22:0],8'h0,sti}),
			.in3({addout[26:0],por,1'h0}));

  spdec spdecode(	.spmd(spmd),
			.lin(lin),
			.laovf(laovf),
			.alow(addout[4:0]),
			.sti(sti),
			.mout_sel(mout_sel),
                 	.mout_dr(mout_dr),
			.iovf(iovf),
			.movf(movf));


endmodule
