module pri_dec(m0,m1,m2,m3,m4,prifunc,nx_prifunc_rom0,nx_prifunc_rom1,
	       romsel, clk, reset_l, fpuhold);
// Priority encode and Left Shift func Block.

 input [2:0] prifunc, nx_prifunc_rom0, nx_prifunc_rom1;
 input 	     clk,reset_l, fpuhold;
 input [1:0] romsel;
 output  [1:0] m2,m3,m1;
 output        m0, m4;

reg [1:0] m2,m3,m1_rom0,m1_rom1;
wire [1:0] m1, nx_m1;
wire m0;

wire fpuhold_l = ~fpuhold;


  always @(nx_prifunc_rom0)  
   begin
    casex(nx_prifunc_rom0)     // synopsys full_case parallel_case
      3'b000,
      3'b11x:    m1_rom0=2'h2;
      3'b001,
      3'b010:    m1_rom0=2'h1;
      3'b101:    m1_rom0=2'h3;
      default: m1_rom0=2'h0;
    endcase
   end

  always @(nx_prifunc_rom1)
   begin
    casex(nx_prifunc_rom1)     // synopsys full_case parallel_case
      3'b000,
      3'b11x:    m1_rom1=2'h2;
      3'b001,    
      3'b010:    m1_rom1=2'h1;
      3'b101:    m1_rom1=2'h3;
      default: m1_rom1=2'h0;
    endcase
   end


mj_s_mux3_d_2 m1_mux(	.mx_out(nx_m1),
			.sel(romsel),
			.in0(m1_rom0),
			.in1(m1_rom1),
			.in2(2'h2));

mj_s_ff_snre_d_2 m1_ff(	.out(m1),
			.din(nx_m1),
			.reset_l(reset_l),
			.clk(clk),
                        .lenable(fpuhold_l));
   
assign m0 = ((prifunc==3'h1) || (prifunc==3'h2));

  always @(prifunc)  
     if((prifunc==3'h1) || (prifunc==3'h4))  
	m2 = 2'h2;
     else if((prifunc==3'h2) || (prifunc==3'h3))  
	m2 = 2'h1;
     else                                         
	m2 = 2'h0;

  always @(prifunc)  
     if(prifunc==3'h0)  
	m3 = 2'h0;
     else if(prifunc==3'h6)  
	m3 = 2'h1;
     else                    
	m3 = 2'h2;

  assign m4 = (prifunc==3'h7);
 
endmodule
