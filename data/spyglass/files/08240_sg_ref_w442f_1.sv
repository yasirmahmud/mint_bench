module w442f_ex1 (input clk, input rst, output reg q);
 always @ (posedge clk or posedge rst) begin if (rst > 0) begin q <= 1'b0;
 end else begin q <= ~q;
 end end endmodule
