module latch_w18_ex1 (input enable, input d, output reg q);
 always @* begin if (enable) q = d;
 end endmodule
