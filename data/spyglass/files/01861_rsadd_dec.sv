module rsadd_dec(	
		//	r0md,
			bsmd,
			acin,
			rsfunc,
		//	nx_rsfunc_rom0,
		//	nx_rsfunc_rom1,
		//	romsel,
			nextstin,
			nxstin,
                 	a0zero,
			rs32,
			stin,
			erop,
		//	clk,
		//	reset_l,
		//	fpuhold_l,
			sm, 
			sin,
			so
			);

input [2:0]  rsfunc; 		//nx_rsfunc_rom0, nx_rsfunc_rom1;
input        rs32, a0zero, nxstin, erop, stin;  // return from RSHIFT.
//input [1:0]  romsel;
input sm, sin;
output [1:0] bsmd; 		//r0md, 
output       acin, nextstin;
output so;

//wire   [3:0] stmdx;

reg  [1:0]  stmd, bsmd;

/*********************************
wire [1:0]  nx_r0md, r0md;
reg  [1:0]  r0md_rom0, r0md_rom1;

 always @(nx_rsfunc_rom0) 
   begin
      casex(nx_rsfunc_rom0)    // synopsys full_case parallel_case
         3'b000:  r0md_rom0 = 2'h2;
         3'b001,
         3'b010,
         3'b11x:  r0md_rom0 = 2'h0;
         3'b011,
         3'b10x:  r0md_rom0 = 2'h1;
         default: r0md_rom0 = 2'hx;
      endcase
   end

 always @(nx_rsfunc_rom1)
   begin
      casex(nx_rsfunc_rom1)    // synopsys full_case parallel_case
         3'b000:  r0md_rom1 = 2'h2;
         3'b001,
         3'b010,
         3'b11x:  r0md_rom1 = 2'h0;
         3'b011,
         3'b10x:  r0md_rom1 = 2'h1;
         default: r0md_rom1 = 2'hx;
      endcase
   end


mj_s_mux3_d_2 r0md_mux(		.mx_out(nx_r0md),
				.sel(romsel),
				.in0(r0md_rom0),
				.in1(r0md_rom1),
				.in2(2'h2));

mj_s_ff_snre_d_2 r0md_ff(	.out(r0md),
				.din(nx_r0md),
				.reset_l(reset_l),
				.clk(clk),
				.lenable(fpuhold_l));
************************************/

 always @(rsfunc) 
   begin
      casex(rsfunc)    // synopsys full_case parallel_case
         3'b0x0,
         3'b101:  bsmd = 2'h0;
         3'b001,
         3'b11x:  bsmd = 2'h1;
         3'b011,
         3'b100:  bsmd = 2'h2;
         default: bsmd = 2'hx;
       endcase
   end

 assign acin = (rsfunc==3'h3);

always @(rsfunc or a0zero or rs32 or erop or stin) begin
      case(rsfunc)            // synopsys parallel_case
         3'h0:  stmd=2'h1;              // x.stin = 0; 
         3'h3:  stmd = {erop,1'b0};   	// x.stin = s.stin;
         3'h7:  stmd = (!a0zero || stin) ? 2'h2: 2'h1;    // x.stin = (!s.a0) ? 0 : 1;
         3'h6: begin
                  if(rs32) 
		    stmd = (a0zero) ? 2'h1 : 2'h2; // x.stin = (s.a0) ? 1 : 0;
                  else     
		    stmd = 2'h3;                // x.stin = nxstin;  (I)
               end
         default:  stmd = 2'h3;                 // x.stin = nxstin;
      endcase
end



mj_s_mux4_d stinout(	.mx_out(nextstin),
			.sel(stmd),
			.in0(stin),
			.in1(1'h0),
			.in2(1'h1),
			.in3(nxstin));

endmodule
