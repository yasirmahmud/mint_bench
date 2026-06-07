module Async_UpCounter  (clk_i,rst_i,count);

input clk_i,rst_i;
output [2:0]count;

// Wires to store inverted outputs for clocking subsequent flip-flops.
// This resolves the linting violation where 'count' signals are directly used as clocks
// (STARC05-1.4.3.4).
wire not_q0;
wire not_q1;

assign not_q0 = ~count[0];
assign not_q1 = ~count[1];

// Asynchronous up-counter implementation based on natural language description:
// - Uses T flip-flops (J=1, K=1)
// - Clocked by previous flip-flop's *inverted* output for up-counting behavior
JK_FlipFlop j1(.clk_i(clk_i),      .rst_i(rst_i), .j(1), .k(1), .Q(count[0]));
JK_FlipFlop j2(.clk_i(not_q0),     .rst_i(rst_i), .j(1), .k(1), .Q(count[1])); // Clocked by inverted output of j1
JK_FlipFlop j3(.clk_i(not_q1),     .rst_i(rst_i), .j(1), .k(1), .Q(count[2])); // Clocked by inverted output of j2

endmodule
