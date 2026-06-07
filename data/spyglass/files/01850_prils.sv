module prils(a1,a0,prifunc,mconfunc,lsround,incinfunc,stin,lsout,saout,priout,
	     multout,nx_prifunc_rom0,nx_prifunc_rom1,romsel,clk,reset_l, fpuhold, so, sin, sm);
// Priority and left-shift module.

input  [31:0]  a1,a0,multout;
input   [2:0]  prifunc,incinfunc,nx_prifunc_rom0,nx_prifunc_rom1;
input   [1:0]  mconfunc, romsel;
input          stin;     // sticky register input.
input	       clk,reset_l, fpuhold;
input   [4:0]  saout;     // Shift amount Input.

output so;
input sm, sin;

output [31:0]  lsout;    // Left Shift module output.
output         lsround;  // Left Shift ROUND output.
output  [5:0]  priout;

wire    [1:0]  m1c,m2c,m3c;
wire           m4,lsdprec,m0c;


prils_cntl  i_prils_cntl(.lsdprec(lsdprec),
			     .m1c(m1c),
			     .m3c(m3c),
			     .m0c(m0c),
			     .m4(m4),
			     .m2c(m2c),
			     .prifunc(prifunc),
			     .incinfunc(incinfunc),
			     .nx_prifunc_rom0(nx_prifunc_rom0),
			     .nx_prifunc_rom1(nx_prifunc_rom1),
			     .clk(clk),
			     .reset_l(reset_l),
			     .fpuhold(fpuhold),
			     .romsel(romsel),
		 		.sm(),
				.sin(),
				.so()	
			 );


prils_dp    i_prils_dp ( .lsout(lsout),
			     .lsround(lsround),
			     .priout(priout),
			     .a1(a1),
			     .a0(a0),
			     .multout(multout),
			     .stin(stin),
			     .m0c(m0c),
			     .m4(m4),
			     .m1c(m1c),
			     .m2c(m2c),
			     .saout(saout),
			     .m3c(m3c),
			     .mconfunc(mconfunc),	
			     .lsdprec(lsdprec)
			 );


endmodule
