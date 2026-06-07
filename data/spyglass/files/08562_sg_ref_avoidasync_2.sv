module async_reset_ex2 (clk, rst, in, out);
 input clk, rst, in;
 output out;
 reg out;
 always @ (posedge clk or posedge rst) begin if (rst) out = 1'b0;
 else out = in;
 end endmodule
