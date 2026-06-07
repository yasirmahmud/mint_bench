module mantissa_cntl (
    a0func, a1func, a2func, ae_small, eadd, morethree_taken, expsame, altb,
    a2, nxa2, fpu_state, clk, reset_l, cyc0_rdy, cyc1_rdy, cyc0_type,
    manzero, mconfunc, a0psel, a1psel, fp_out_sel, a1sel, a0sel, b0sel_a,
    b0sel_b, b1sel, b1psel, b1msbin, amsb, bmsb, a1comp, b1comp, a0comp,
    b0comp, a_small, a1zzsel, b1_cyc0sel, fpuhold, cyc0_sel, sm, sin, so
  );
    input [2:0] a0func, a1func, a2func, cyc0_type;
    input [7:0] fpu_state;
    input [1:0] mconfunc;
    input ae_small, eadd, morethree_taken, expsame, altb, nxa2, clk, reset_l, cyc0_rdy, cyc1_rdy, amsb, bmsb, fpuhold;
    input sm, sin; // Added to fix W240 in parent module
    output a2, manzero, b1psel, b1msbin, a1comp, b1comp, a0comp, b0comp, a_small, a1zzsel, b1_cyc0sel, so;
    output [2:0] a0psel, fp_out_sel, a1sel, a0sel;
    output [1:0] a1psel, b0sel_a, b0sel_b, b1sel, cyc0_sel;
  endmodule
