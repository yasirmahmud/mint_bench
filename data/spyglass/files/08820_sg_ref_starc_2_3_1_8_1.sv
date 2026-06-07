module STARC_2_3_1_8_ex1 (input clk, output reg q);
 always begin wait (posedge clk);
 q <= 1'b0;
 end endmodule
