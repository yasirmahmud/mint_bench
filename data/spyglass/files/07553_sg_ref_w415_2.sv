module W415_ex2 (input clk, input rst, input a, input b, output reg out_reg);
 always @(posedge clk or posedge rst) begin if (rst) out_reg <= 1'b0;
 else if (a) out_reg <= 1'b1;
 end always @(posedge clk) begin if (b) out_reg <= 1'b0;
 end endmodule
