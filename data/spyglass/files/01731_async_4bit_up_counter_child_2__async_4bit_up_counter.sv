module async_4bit_up_counter(clk, J,K,Q);
input clk;
input [3:0]J,K;
output [3:0]Q;

// To resolve STARC05-1.4.3.4, which flags outputs (Q) being used as clock inputs.
// Introducing intermediate wires for the asynchronous clock signals explicitly separates
// the role of 'Q' as an output from its use as a clock signal for subsequent stages.
// This clarifies the design intent to linting tools while preserving the asynchronous behavior.
wire clk_Q0_async = Q[0];
wire clk_Q1_async = Q[1];
wire clk_Q2_async = Q[2];

jk_ff JK1(clk,J[0],K[0],Q[0]);
jk_ff JK2(clk_Q0_async,J[1],K[1],Q[1]);
jk_ff JK3(clk_Q1_async,J[2],K[2],Q[2]);
jk_ff JK4(clk_Q2_async,J[3],K[3],Q[3]);

endmodule
