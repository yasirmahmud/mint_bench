module mpselect(mp6, mp5, mp4, mp3, mp2, mp1, mp0, multiplier, mcant, mcan, 
		mcanmi, signbit);

// this module uses radix-4 booth recoding to select multiplicands.
// there are 7 values of multiplicands selected because we "look" at 2 bits 
// of the multiplier input at a time (therefore 14/2 = 7).  (booth actually
// needs a third bit (bit(i-1)) in order to resolve the multiplicand
// selection for the 2 bits we are taking care of.)

 output [27:0]   mp6, mp5, mp4, mp3, mp2, mp1, mp0;
 output [6:0]	 signbit;
 input  [26:0]   mcan;
 input  [14:0]   multiplier;
 input		 mcant, mcanmi;

 wire   [1:0]	 mselx0, mselx1, mselx2, mselx3, mselx4, mselx5, mselx6;
 wire		 negsel0, negsel1, negsel2, negsel3, negsel4, negsel5, negsel6;

   fpu_booth  booth0 (.mselx(mselx0),.negsel(negsel0),
			.bits(multiplier[2:0]), .signbit(signbit[0]));
   fpu_booth  booth1 (.mselx(mselx1),.negsel(negsel1),
			.bits(multiplier[4:2]), .signbit(signbit[1]));
   fpu_booth  booth2 (.mselx(mselx2),.negsel(negsel2),
			.bits(multiplier[6:4]), .signbit(signbit[2]));
   fpu_booth  booth3 (.mselx(mselx3),.negsel(negsel3),
			.bits(multiplier[8:6]), .signbit(signbit[3]));
   fpu_booth  booth4 (.mselx(mselx4),.negsel(negsel4),
			.bits(multiplier[10:8]), .signbit(signbit[4]));
   fpu_booth  booth5 (.mselx(mselx5),.negsel(negsel5),
			.bits(multiplier[12:10]), .signbit(signbit[5]));
   fpu_booth  booth6 (.mselx(mselx6),.negsel(negsel6),
			.bits(multiplier[14:12]), .signbit(signbit[6]));

   mpmux      mpselect0 (.mcant(mcant), .mcan(mcan), .mcanmi(mcanmi), 
			.negsel(negsel0), .mselx(mselx0), .mp(mp0));
   mpmux      mpselect1 (.mcant(mcant), .mcan(mcan), .mcanmi(mcanmi), 
			.negsel(negsel1), .mselx(mselx1), .mp(mp1));
   mpmux      mpselect2 (.mcant(mcant), .mcan(mcan), .mcanmi(mcanmi), 
			.negsel(negsel2), .mselx(mselx2), .mp(mp2));
   mpmux      mpselect3 (.mcant(mcant), .mcan(mcan), .mcanmi(mcanmi), 
			.negsel(negsel3), .mselx(mselx3), .mp(mp3));
   mpmux      mpselect4 (.mcant(mcant), .mcan(mcan), .mcanmi(mcanmi), 
			.negsel(negsel4), .mselx(mselx4), .mp(mp4));
   mpmux      mpselect5 (.mcant(mcant), .mcan(mcan), .mcanmi(mcanmi), 
			.negsel(negsel5), .mselx(mselx5), .mp(mp5));
   mpmux      mpselect6 (.mcant(mcant), .mcan(mcan), .mcanmi(mcanmi), 
			.negsel(negsel6), .mselx(mselx6), .mp(mp6));

endmodule
