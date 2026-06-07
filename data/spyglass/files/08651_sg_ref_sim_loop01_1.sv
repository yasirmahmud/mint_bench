module sim_loop01_ex1(input clk, output reg out);
 reg a;
 always @* a = out;
 assign out = a;
 endmodule
