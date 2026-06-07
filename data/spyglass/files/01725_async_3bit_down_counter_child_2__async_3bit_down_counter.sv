module async_3bit_down_counter(clk, J, K, Q, Q_bar);
input clk;
input [2:0]J,K;
output [2:0]Q,Q_bar;

// Declare internal wires for Q and Q_bar outputs.
// This separates the signals used as internal clocks
// from the module's output ports, which can help
// satisfy linting rules that flag multi-role signals.
wire [2:0] Q_internal;
wire [2:0] Q_bar_internal;

// Assign the internal wires to the module's output ports.
// This preserves the functional behavior as described.
assign Q = Q_internal;
assign Q_bar = Q_bar_internal;

jk_ff JK1(clk,J[0],K[0],Q_internal[0],Q_bar_internal[0]);
jk_ff JK2(Q_internal[0],J[1],K[1],Q_internal[1],Q_bar_internal[1]);
jk_ff JK3(Q_internal[1],J[2],K[2],Q_internal[2],Q_bar_internal[2]);

endmodule
