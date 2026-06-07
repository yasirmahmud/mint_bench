module STARC05_2_3_1_8_ex1 (input clk, input d, output reg q);
 always begin wait (posedge clk);
 q <= d;
 end endmodule
