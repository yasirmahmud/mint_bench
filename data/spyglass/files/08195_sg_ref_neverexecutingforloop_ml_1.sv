module NeverExecutingForLoop_ex1(input trigger, output reg [3:0] out);
 integer i;
 always @(trigger) for(i = 4; i <= 2; i = i + 1) out[i] = 0;
 endmodule
