module badimplicitSM1_ex1(input clk, input rst, input en, output reg q);
 always @(posedge clk or posedge rst) begin if (en) q <= 1'b1;
 else if (rst) q <= 1'b0;
 else q <= 1'b0;
 end endmodule
