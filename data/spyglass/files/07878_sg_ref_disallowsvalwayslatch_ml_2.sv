module disallow_sv_always_latch_ex2 (input r, input d, output reg q);
 always_latch if (r) q <= 1'b0;
 else q <= d;
 endmodule
