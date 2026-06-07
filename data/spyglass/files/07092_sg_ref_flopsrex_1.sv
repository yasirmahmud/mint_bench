module FlopSREX_ex1 (input clk, input d, output reg q);
 wire rst;
 always @(posedge clk or posedge rst) begin if (rst) q <= 1'b0;
 else q <= d;
 end endmodule
