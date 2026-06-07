module inc_decode(	t1md, 
			t0md, 
			l1md, 
			l0md, 
			incfunc, 
			nx_incfunc_rom0, 
			nx_incfunc_rom1, 
			romsel,
//			rsovf, 
//			amsb, 
//			eadd, 
			si,
                  	loadd_cin, 
			zmd,
			clk,
			reset_l,
     			so,
			sin,
			sm,
			fpuhold_l
			);

// INCrement module DECoder

input  [3:0]   incfunc, nx_incfunc_rom0, nx_incfunc_rom1;
input          clk, reset_l, fpuhold_l;
input  [1:0]   romsel;
input	       sin, sm;

output	       so;
output [1:0]   t1md;
output [1:0]   l1md, t0md, l0md;
output         zmd;
output         si, loadd_cin;

wire    [1:0]   t1md, t1mda, nx_t1mda;
wire    [1:0]   t1mda_rom0, t1mda_rom1;
wire    [1:0]   nx_t0md, nx_l1md, t0md, l1md, t0md_rom0,
		t0md_rom1, l1md_rom0, l1md_rom1;
wire   [1:0]    nx_l0md, l0md, l0md_rom0, l0md_rom1;

//wire	[2:0]	nx_t1mdb, t1mdb_0_rom0, t1mdb_0_rom1, t1mdb_1_rom0,
//		t1mdb_1_rom1; 
//wire	[2:0]   t1mdb_0, t1mdb_1;
wire           zmd;

inc_t1mda_rom i0 (	.t1mda_rom(t1mda_rom0), 
			.nx_incfunc_rom(nx_incfunc_rom0));
inc_t1mda_rom i1 (	.t1mda_rom(t1mda_rom1), 	
			.nx_incfunc_rom(nx_incfunc_rom1));

inc_t0md_rom i5 (	.t0md_rom(t0md_rom0), 
			.nx_incfunc_rom(nx_incfunc_rom0));
inc_t0md_rom i6 (	.t0md_rom(t0md_rom1), 
			.nx_incfunc_rom(nx_incfunc_rom1));

inc_l1md_rom i7 (	.l1md_rom(l1md_rom0), 
			.nx_incfunc_rom(nx_incfunc_rom0));
inc_l1md_rom i8 (	.l1md_rom(l1md_rom1), 
			.nx_incfunc_rom(nx_incfunc_rom1));

inc_l0md_rom i9 (	.l0md_rom(l0md_rom0), 
			.nx_incfunc_rom(nx_incfunc_rom0));
inc_l0md_rom i10 (	.l0md_rom(l0md_rom1), 
			.nx_incfunc_rom(nx_incfunc_rom1));

mj_s_mux3_d_2 t1mda_mux(	.mx_out(nx_t1mda),
				.sel(romsel),
				.in0(t1mda_rom0),
				.in1(t1mda_rom1),
				.in2(2'h2));

mj_s_mux3_d_2 t0md_mux(		.mx_out(nx_t0md),
				.sel(romsel),
                        	.in0(t0md_rom0),
                        	.in1(t0md_rom1),
                        	.in2(2'h2));

mj_s_mux3_d_2 l1md_mux(		.mx_out(nx_l1md),
				.sel(romsel),
                        	.in0(l1md_rom0),
                        	.in1(l1md_rom1),
                        	.in2(2'h0));

mj_s_mux3_d_2 l0md_mux(        	.mx_out(nx_l0md),
                        	.sel(romsel),
                        	.in0(l0md_rom0),
                        	.in1(l0md_rom1),
                        	.in2(2'h2));


mj_s_ff_snre_d_2 t1mda_ff(      .out(t1mda),
                        	.din(nx_t1mda),
                        	.reset_l(reset_l),
                        	.clk(clk),
				.lenable(fpuhold_l));

mj_s_ff_snre_d_2 t0md_ff(       .out(t0md),
                        	.din(nx_t0md),
                       		.reset_l(reset_l),
                        	.clk(clk),
				.lenable(fpuhold_l));

mj_s_ff_snre_d_2 l0md_ff(       .out(l0md),
                        	.din(nx_l0md),
                       		.reset_l(reset_l),
                        	.clk(clk),
				.lenable(fpuhold_l));

mj_s_ff_snre_d_2 l1md_ff(       .out(l1md),
                        	.din(nx_l1md),
                       		.reset_l(reset_l),
                        	.clk(clk),
				.lenable(fpuhold_l));

// assign t1mdb = (amsb) ? t1mdb_1 : t1mdb_0 ;

// assign t1md = (eadd && rsovf) ? t1mda : t1mdb;

assign t1md = t1mda;

 assign si        = !(incfunc==4'ha);
 assign loadd_cin = (incfunc==4'h8);
 assign zmd       = (incfunc==4'ha);


endmodule
