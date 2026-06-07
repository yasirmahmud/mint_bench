module starc05_2_9_2_4_ex1 (clk, reset, d, q);
 input clk;
 input reset;
 input d;
 output reg q;
 integer i;
 always @ (posedge clk or negedge reset) for (i = 0; i < 1; i = i + 1) if (!reset) q = 1'b0;
 else q = d;
 endmodule
