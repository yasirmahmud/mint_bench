module latch_ex1 (q, d, en);
 output q;
 input d, en;
 reg q;
 always @* if (en) q = d;
 endmodule
