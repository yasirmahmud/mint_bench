module cond_delay_ex1(input clk, input cond, input d, output reg q);
 always @(posedge clk) if(cond) q <= #1 d;
 else q <= d;
 endmodule
