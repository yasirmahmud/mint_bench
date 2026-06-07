module exptop_dec(mux1ad,mux2ad,mux2bd,addtcin,addlcin,ef,ef_rom0,ef_rom1,
		  romsel,saf,clk,reset_l,fpuhold_l,sm,sin,so);

input [3:0] ef, ef_rom0, ef_rom1;
input [2:0] saf;
input [1:0] romsel;
input       clk, reset_l, fpuhold_l;
input		sm,sin;

output		so;
output addtcin,addlcin;
output [1:0] mux2bd;
output [1:0] mux1ad,mux2ad;

reg [1:0] mux2ad,mux2bd,mux1ad_rom0, mux1ad_rom1;
wire       addtcin,addlcin;
wire [1:0] mux1ad, nx_mux1ad;

always @(ef_rom0)
        if(ef_rom0==4'hd)
                mux1ad_rom0 = 2'h2;  // bexp.
        else if((ef_rom0[3:1]==3'b100) || (ef_rom0==4'h3))
                mux1ad_rom0 = 2'h1;  // excon.
        else
                mux1ad_rom0 = 2'h0;  // ~excon. good

always @(ef_rom1)
        if(ef_rom1==4'hd)
                mux1ad_rom1 = 2'h2;  // bexp.
        else if((ef_rom1[3:1]==3'b100) || (ef_rom1==4'h3))
                mux1ad_rom1 = 2'h1;  // excon.
        else
                mux1ad_rom1 = 2'h0;  // ~excon. good

mj_s_mux3_d_2 mux1ad_mux(	.mx_out(nx_mux1ad),
				.sel(romsel),
				.in0(mux1ad_rom0),
				.in1(mux1ad_rom1),
				.in2(2'h0));


mj_s_ff_snre_d_2 mux1ad_ff(	.out(mux1ad),
				.din(nx_mux1ad),
				.reset_l(reset_l),
				.clk(clk),
				.lenable(fpuhold_l));


always @(ef or saf)
        if(saf==3'h2)
                mux2ad = 2'h1;  // sa
        else if((ef==4'h8) || ( & ef) || (ef==4'ha))
                mux2ad = 2'h2;  // aexp
        else
                mux2ad = 2'h0;  // excon.

always @(ef or saf)
        if((saf==3'h3) || (saf==3'h6) || (saf==3'h1))
                mux2bd = 2'h1;  // ~aexp.
        else if(& ef)
                mux2bd = 2'h2;  // for aexp++
        else if(ef==4'ha)
                mux2bd = 2'h3;  // for aexp--
        else
                mux2bd = 2'h0;  // ~excon.

// ef==7:  will perform aexp-bexp to determine the AE_small signal(TOPSIGN=1) // means AEXP < BEXP.

assign addtcin = !((ef[0] & ef[1] & !ef[2] & !ef[3]) || 
                   (ef[3] & !ef[2] & !ef[1]) || 
                   (ef[0] & !ef[1] & ef[2] & ef[3]));

assign addlcin = !((&ef) || (!ef[0] & ef[1] & !ef[2] & ef[3]));

endmodule
