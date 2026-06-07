module expbot_dec(muxlimd,muxsad_a,muxsad_b,
		  muxpaed_a, muxpaed_b, muxpaed_c, muxbed,muxaed,ef,
		  safunc, topsign,movf,erop);

input       erop,topsign,movf;
input [3:0] ef;
input [2:0] safunc;

output [1:0] muxlimd;
output [1:0] muxaed, muxpaed_a, muxpaed_b, muxpaed_c, muxsad_a, muxsad_b;
output 	     muxbed;

wire  [1:0]   muxlimd,muxsad_a,muxsad_b,muxaed,muxpaed_a,muxpaed_b,
	      muxpaed_c;
wire          muxbed;

 //  Below TOPSIGN is eqivalent to AE_SMALL indicator.
expbot_muxlimd expbot0(.safunc(safunc), .muxlimd(muxlimd));

expbot_muxsad  expbot1(.muxsad_b(muxsad_b), 
		       .muxsad_a(muxsad_a), 
		       .safunc(safunc));

expbot_muxaed  expbot2(.muxaed(muxaed), 
		       .ef(ef), 
		       .topsign(topsign), 
		       .movf(movf), 
		       .erop(erop));

expbot_muxpaed  expbot3(.muxpaed_a(muxpaed_a), 
		        .muxpaed_b(muxpaed_b), 
			.muxpaed_c(muxpaed_c), 
			.ef(ef));


assign muxbed = ((ef==4'h7) && topsign) || (ef==4'h5);   // aexp.

endmodule
