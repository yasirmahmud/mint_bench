// SpyGlass violation 2E: Design Unit 'mantissa_dp' has no definition; black-box behavior assumed
  // Adding a stub module definition to resolve this.
  module mantissa_dp (
    rsout, lsout, a0inc, a1inc, a1, a0, b1, b0, nx_rsfunc_rom0, nx_rsfunc_rom1,
    romsel, r1out, r0out, nxa2, cyc0_rdy, fpout, asign, clk, reset_l, fpain,
    fpbin, aexpout, a0psel, a1psel, fp_out_sel, a1sel, a0sel, b1msbin, b0sel_a,
    b0sel_b, b1sel, b1psel, a1comp, b1comp, a0comp, b0comp, amsb, a0func,
    a_small, a1zzsel, b1_cyc0sel, fpuhold, cyc0_sel, sm, sin, so
  );
    input [31:0] rsout, lsout, a0inc, a1inc, fpain, fpbin;
    input [10:0] aexpout;
    input [2:0] nx_rsfunc_rom0, nx_rsfunc_rom1, a0psel, fp_out_sel, a1sel, a0sel, a0func;
    input [1:0] romsel, a1psel, b0sel_a, b0sel_b, b1sel, cyc0_sel;
    input nxa2, cyc0_rdy, asign, clk, reset_l, b1msbin, b1psel, a1comp, b1comp, a0comp, b0comp, a_small, a1zzsel, b1_cyc0sel, fpuhold;
    input sm, sin; // Added to fix W240 in parent module
    output [31:0] a1, a0, b1, b0, r1out, r0out, fpout;
    output amsb, so;
  endmodule
