module zero_det (mag_a, mag_b, nxt_rbb,
                 sel_swap,  cyc_compare, mul_cmp,
                 ld_a_oprd0,  ld_b_oprd0,  ld_leading0,
                 clr_a_oprd0, clr_b_oprd0,
                 clk,
                 ain_is0, bin_is0, div_ovf, extreme_2, leading0_r);

input  [31:0]  mag_a; 
input  [31:0]  mag_b; 
input  [31:0]  nxt_rbb; 
input          sel_swap; 
input          cyc_compare; 
input          mul_cmp;
input          ld_a_oprd0;
input          ld_b_oprd0;
input          ld_leading0;
input          clr_a_oprd0;
input          clr_b_oprd0;
input          clk;

output         ain_is0;
output         bin_is0;
output         div_ovf;
output         extreme_2;
output         leading0_r;

wire           ain_is0_r, bin_is0_r, div_ovf_r, leading0_r;
wire   [31:0]  inp_b;
wire           zero32_a,    zero32_b;
wire                        bop312_0;
wire           leading0;

wire           zero_31_2_a, zero_31_2_b, d_ovf;

  zero_a_32 zero_a_32_0 (
                         .inp(mag_a),
                         .zero_31_2(zero_31_2_a),
                         .zero32(zero32_a) 
                        );

/*  Logic    
  assign inp_b = cyc_compare ? mag_b : nxt_rbb;
*/

  mx2_32 mx2_32_a (
                   .inp1(mag_b),
                   .inp0(nxt_rbb),
                   .sel(cyc_compare),
                   .out(inp_b)
                  );

  zero_b_32 zero_b_32_0 (
                         .inp(inp_b),
                         .mag_a31(mag_a[31]),
                         .zero_31_2(zero_31_2_b),
                         .zero32(zero32_b),
                         .d_ovf(d_ovf)
                        );

  assign bop312_0 = sel_swap ? zero_31_2_a : zero_31_2_b;

  assign ain_is0  = ld_a_oprd0  ? (!clr_a_oprd0 && zero32_a) : ain_is0_r;
  assign bin_is0  = ld_b_oprd0  ? (!clr_b_oprd0 && zero32_b) : bin_is0_r;
  assign div_ovf  = ld_b_oprd0  ? (!clr_b_oprd0 && d_ovf)    : div_ovf_r;
  assign leading0 = ld_leading0 ? (!clr_b_oprd0 && bop312_0) : leading0_r;

  assign extreme_2 = (!mul_cmp && div_ovf) || ain_is0 || bin_is0;

/*  Logic   
  always @ (posedge clk) begin
    ain_is0_r   <= (sm ? sin : ain_is0);
    bin_is0_r   <= (sm ? sin : bin_is0);
    div_ovf_r   <= (sm ? sin : div_ovf);
    leading0_r  <= (sm ? sin : leading0);
  end
*/

/* gate flip-flop */
  ff_s_4 ff_s_4_0 (
                   .out({ain_is0_r,bin_is0_r,div_ovf_r,leading0_r}),
                   .din({ain_is0,  bin_is0,  div_ovf,  leading0}),
                   .clk(clk)
                  );

endmodule
