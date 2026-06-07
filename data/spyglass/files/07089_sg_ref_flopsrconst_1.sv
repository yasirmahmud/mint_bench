module FlopSRConst_ex1(input clk, input d, output reg q);
 wire rst_const = 1'b1;
 always @(posedge clk or posedge rst_const) begin if (rst_const) begin q <= 1'b0;
 end else begin q <= d;
 end end endmodule
