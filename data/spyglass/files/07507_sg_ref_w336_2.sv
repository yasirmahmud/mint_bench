module W336_ex2(input clk, rst, in, output reg out);
 always @(posedge clk or posedge rst) begin if (rst) out = 1'b0;
 else out = in;
 end endmodule
