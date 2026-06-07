module starc05_2_3_1_2a_ex1(input clk, input rst, input d, output reg q);
 wire w;
 always @(posedge clk or posedge rst) begin if (rst) q <= 1'b0;
 else assign w = d;
 end assign q = w;
 endmodule
