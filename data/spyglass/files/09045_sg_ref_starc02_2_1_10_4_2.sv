module while_loop_ex2 (input clk, output reg out);
 reg [3:0] i;
 always @(posedge clk) begin i = 0;
 while (i < 5) begin i = i + 1;
 end out = (i == 5);
 end endmodule
