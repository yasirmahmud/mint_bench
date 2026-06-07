module latch_enable_x_ex2 (input d, output reg q);
 wire enable_x;
 assign enable_x = 1'bx;
 always @(d or enable_x) begin if (enable_x) begin q = d;
 end end endmodule
