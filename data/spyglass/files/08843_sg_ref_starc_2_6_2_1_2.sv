module starc_2_6_2_1_ex2 (input clk, rst, in_a, [0:0] sel, output reg out_q);
 always @(posedge clk or posedge rst) begin if (rst) out_q <= 1'b0;
 case (sel) 1'b0: out_q <= in_a;
 1'b1: out_q <= 1'b1;
 endcase end endmodule
