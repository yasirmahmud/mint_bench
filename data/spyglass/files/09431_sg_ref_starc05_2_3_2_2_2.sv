module STARC05_2_3_2_2_ex2 (input clk, input rst, input a, output reg out_b, output reg out_nb);
 always @(posedge clk or posedge rst) begin if (rst) begin out_b = 1'b0;
 out_nb <= 1'b0;
 end else begin out_b = a;
 out_nb <= a;
 end end endmodule
