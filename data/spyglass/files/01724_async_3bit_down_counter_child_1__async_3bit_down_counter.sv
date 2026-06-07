module async_3bit_down_counter(clk, J,K,Q,Q_bar);
input clk;
input [2:0]J,K;
output [2:0]Q,Q_bar;

jk_ff JK1(clk,J[0],K[0],Q[0],Q_bar[0]);
jk_ff JK2(Q[0],J[1],K[1],Q[1],Q_bar[1]);
jk_ff JK3(Q[1],J[2],K[2],Q[2],Q_bar[2]);

endmodule
