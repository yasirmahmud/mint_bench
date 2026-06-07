module w442f_ex2 (input clk, input rst, input d, output reg q);
 always @ (posedge clk or posedge rst) begin if (rst > 1'b0) begin q <= 1'b0;
 end else begin q <= d;
 end end endmodule
