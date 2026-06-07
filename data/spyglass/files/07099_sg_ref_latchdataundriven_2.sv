module latch_undriven_ex2(input enable, output reg q);
 wire d;
 always @(enable) if (enable) q <= d;
 endmodule
