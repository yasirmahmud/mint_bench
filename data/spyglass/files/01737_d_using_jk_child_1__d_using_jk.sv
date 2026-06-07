module d_using_jk(clk,D,Q,Q_bar);
input clk, D;
output Q,Q_bar;

jk_ff JKF(clk, D,~D, Q,Q_bar );
endmodule
