module async_4bit_down_counter(clk, J,K,Q,Q_bar);
input clk;
input [3:0]J,K;
output [3:0]Q,Q_bar;

// Declare internal wires for the Q and Q_bar signals to separate them from the output ports.
// This helps prevent linting tools from flagging the output ports themselves as "clocks used as non-clocks"
// when they are also driving the clock inputs of subsequent flip-flops in an asynchronous cascade.
wire [3:0] q_internal;
wire [3:0] q_bar_internal;

jk_ff JK1(clk,J[0],K[0],q_internal[0],q_bar_internal[0]);
jk_ff JK2(q_internal[0],J[1],K[1],q_internal[1],q_bar_internal[1]);
jk_ff JK3(q_internal[1],J[2],K[2],q_internal[2],q_bar_internal[2]);
jk_ff JK4(q_internal[2],J[3],K[3],q_internal[3],q_bar_internal[3]);

// Assign internal signals to output ports.
assign Q = q_internal;
assign Q_bar = q_bar_internal;

endmodule
