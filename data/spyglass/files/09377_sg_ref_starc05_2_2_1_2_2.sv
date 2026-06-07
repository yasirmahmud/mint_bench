module latch_infer_ex2(input a, input b, output reg q);
 always @(a or b) if (a) q = b;
 endmodule
