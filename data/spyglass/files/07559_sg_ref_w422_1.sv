module w422_ex1(input clk1, input clk2, input rst, output reg out_reg);
 always @(posedge clk1 or posedge clk2) begin if (rst) out_reg <= 1'b0;
 else out_reg <= ~out_reg;
 end endmodule
