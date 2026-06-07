module mod_star_2_9_2_4_ex2 (clk, reset);
 input clk;
 input reset;
 integer i;
 reg out [3:0];
 always @ (posedge clk or negedge reset) for (i = 0; i < 4; i = i + 1) if (!reset) out[i] = 1'b0;
 else out[i] = 1'b1;
 endmodule
