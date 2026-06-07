module W442c_ex2 (input clk, input rst, input enable, output reg q);
 always @ (posedge clk or posedge rst) begin if (rst & enable) begin q <= 1'b0;
 end else begin q <= ~q;
 end end endmodule
