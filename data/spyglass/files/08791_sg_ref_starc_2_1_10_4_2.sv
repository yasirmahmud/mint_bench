module while_loop_ex2(input clk, output reg out);
 integer i;
 always @(posedge clk) begin i = 0;
 while (i < 5) begin out = ~out;
 i = i + 1;
 end end endmodule
