module starc05_1_2_1_2_ex1 (input S, R, output Q, Q_n);
 nor (Q, R, Q_n);
 nor (Q_n, S, Q);
 endmodule
