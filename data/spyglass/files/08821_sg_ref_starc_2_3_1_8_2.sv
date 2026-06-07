module st_2_3_1_8_ex2 (input clk, input d, output reg q);
 always begin wait (clk);
 q <= d;
 end endmodule
