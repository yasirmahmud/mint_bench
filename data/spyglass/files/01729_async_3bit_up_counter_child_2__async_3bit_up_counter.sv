module async_3bit_up_counter(clk, J, K, Q);
input clk;
input [2:0]J,K;
output [2:0]Q;

// Introduce internal wires to separate the signals used as clocks from the output port
wire ff0_q_out; // Output of JK1, acts as clock for JK2
wire ff1_q_out; // Output of JK2, acts as clock for JK3
wire ff2_q_out; // Output of JK3

jk_ff JK1(clk, J[0], K[0], ff0_q_out);
jk_ff JK2(ff0_q_out, J[1], K[1], ff1_q_out);
jk_ff JK3(ff1_q_out, J[2], K[2], ff2_q_out);

// Assign the internal wires to the output port
assign Q[0] = ff0_q_out;
assign Q[1] = ff1_q_out;
assign Q[2] = ff2_q_out;

endmodule
