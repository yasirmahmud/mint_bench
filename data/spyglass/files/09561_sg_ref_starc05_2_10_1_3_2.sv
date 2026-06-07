module starc05_2_10_1_3_ex2(input [1:0] a, output reg q);
 always @(*) begin if (a == 2'bXX) begin q = 1'b1;
 end else begin q = 1'b0;
 end end endmodule
