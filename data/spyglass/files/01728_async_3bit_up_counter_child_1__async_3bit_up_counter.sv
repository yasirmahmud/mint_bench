module async_3bit_up_counter(clk, J, K, Q);
input clk;
input [2:0]J,K;
output [2:0]Q;

wire Q0_out, Q1_out, Q2_out;

jk_ff JK1(clk,J[0],K[0],Q[0]);
jk_ff JK2(Q[0],J[1],K[1],Q[1]);
jk_ff JK3(Q[1],J[2],K[2],Q[2]);

endmodule
