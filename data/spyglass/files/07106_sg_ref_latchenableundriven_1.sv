module latch_enable_undriven_ex1 (input d, output reg q);
 wire enable;
 always @* if (enable) q = d;
 endmodule
