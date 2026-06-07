module multiple_posedge_clk_ex1(input clk, input rst, output reg q);
always @(posedge clk or posedge clk or negedge rst) begin if (!rst) q <= 1'b0;
 else q <= ~q;
 end endmodule
