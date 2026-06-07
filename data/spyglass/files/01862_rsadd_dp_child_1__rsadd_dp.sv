module rsadd_dp ( 		a0zero, 
			a0, 
//			a1, 
//			r0md, 
//			r1md,
//			a2, 
			r1out,
			r0out,
			stin, 
			sticky, 
			saout, 
			b1, 
                  	b0, 
			bsmd, 
			aqcin, 
			rsout, 
			rsovfi 
			);

input  [31:0] a0;
input  [31:0] r0out, r1out;
//input   [1:0] r0md, r1md;
//input  [31:0] a1;
//input         a2;
input   [4:0] saout;
input  [31:0] b1;
input  [31:0] b0;
input   [1:0] bsmd;
input         stin, aqcin;
output [31:0] rsout;
output        a0zero, sticky, rsovfi;

wire   [31:0] rshiftout, bsmuxout;
//wire   [31:0] r0out, r1out;


/*****************************
mj_s_mux3_d_32 muxr0 ( 	.mx_out(r0out),
			.in2(32'h0),
			.in1(a1), 
			.in0(a0), 
			.sel(r0md) 
			);
mj_s_mux3_d_32 muxr1 ( 	.mx_out(r1out),
			.in2(32'h0),
			.in1({32{a2}}), 
			.in0(a1), 
			.sel(r1md) 
			);
**********************************/

mj_s_mux3_d_32 muxbs ( 	.mx_out(bsmuxout),
			.in2(b1), 
			.in1(b0), 
			.in0(32'h0),
			.sel(bsmd) 
			);




  compare_zero_32 a0comp (	.out(a0zero), 
				.in(a0) 
				);



  rshifter rshift1 ( 	.rshiftout(rshiftout), 
			.high(r1out[30:0]),
			.low(r0out),
			.stin(stin), 
			.sticky(sticky),
			.saout(saout)
			);


  cla_adder_32 rsadder ( .in1(bsmuxout),
			 .in2(rshiftout),
			 .cin(aqcin),
			 .sum(rsout),
			 .cout(rsovfi)
			 );

endmodule
