module multmod_cntl ( nx_multfunc_rom0, nx_multfunc_rom1,  
    		      romsel, nx_cyc0_rdy,
		      clk, reset_l, nx_multdec_muxcntl);

input  [3:0] nx_multfunc_rom0, nx_multfunc_rom1;
input  [1:0] romsel;
input  nx_cyc0_rdy; 
input  clk; 
input  reset_l;


output [17:0] nx_multdec_muxcntl;

wire [17:0]   nx_multdec_muxcntl_rom0, nx_multdec_muxcntl_rom1, nx_multdec_muxcntl_0;

   mult_dec muldec_rom0(.multfunc(nx_multfunc_rom0),
			.cyc0_rdy(nx_cyc0_rdy),
			.nx_multdec_muxcntl(nx_multdec_muxcntl_rom0));

   mult_dec muldec_rom1(.multfunc(nx_multfunc_rom1),
			.cyc0_rdy(nx_cyc0_rdy),
			.nx_multdec_muxcntl(nx_multdec_muxcntl_rom1));

   mult_dec muldec_0(.multfunc(4'b0),
			.cyc0_rdy(nx_cyc0_rdy),
			.nx_multdec_muxcntl(nx_multdec_muxcntl_0));

//  wire [2:0] romselx;

mj_s_mux3_d_16 selmultdectop_17_2(.mx_out(nx_multdec_muxcntl[17:2]), 
			.in2(nx_multdec_muxcntl_0[17:2]), 
			.in1(nx_multdec_muxcntl_rom1[17:2]), 
			.in0(nx_multdec_muxcntl_rom0[17:2]), 
			.sel(romsel) );
mj_s_mux3_d_2 selmultdec_1_0(.mx_out(nx_multdec_muxcntl[1:0]), 
			.in2(nx_multdec_muxcntl_0[1:0]), 
			.in1(nx_multdec_muxcntl_rom1[1:0]), 
			.in0(nx_multdec_muxcntl_rom0[1:0]), 
			.sel(romsel) );
 

endmodule
