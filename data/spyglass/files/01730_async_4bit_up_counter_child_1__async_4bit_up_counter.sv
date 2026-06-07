module async_4bit_up_counter(clk, J,K,Q);
input clk;
input [3:0]J,K;
output [3:0]Q;

jk_ff JK1(clk,J[0],K[0],Q[0]);
jk_ff JK2(Q[0],J[1],K[1],Q[1]);
jk_ff JK3(Q[1],J[2],K[2],Q[2]);
jk_ff JK4(Q[2],J[3],K[3],Q[3]);

endmodule
