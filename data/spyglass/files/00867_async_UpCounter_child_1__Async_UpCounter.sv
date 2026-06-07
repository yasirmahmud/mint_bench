module Async_UpCounter  (clk_i,rst_i,count);

input clk_i,rst_i;
output [2:0]count;

// Asynchronous up-counter implementation based on natural language description:
// - Uses T flip-flops (J=1, K=1)
// - Clocked by previous flip-flop's *inverted* output for up-counting behavior
JK_FlipFlop j1(.clk_i(clk_i),      .rst_i(rst_i), .j(1), .k(1), .Q(count[0]));
JK_FlipFlop j2(.clk_i(~count[0]), .rst_i(rst_i), .j(1), .k(1), .Q(count[1])); // Clocked by inverted output of j1
JK_FlipFlop j3(.clk_i(~count[1]), .rst_i(rst_i), .j(1), .k(1), .Q(count[2])); // Clocked by inverted output of j2

endmodule
