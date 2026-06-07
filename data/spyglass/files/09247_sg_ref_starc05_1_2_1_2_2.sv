module rs_latch_ex2 (input R, S, output Q, Q_n);
 nor (Q, R, Q_n);
 nor (Q_n, S, Q);
 endmodule
