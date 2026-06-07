module W313_ex2(input clk, input integer i, output reg r);
 always @(posedge clk) r = i;
 endmodule
