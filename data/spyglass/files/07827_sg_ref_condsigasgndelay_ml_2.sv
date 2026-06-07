module cond_sig_delay_ex2 (input sel, input a, input b, output out);
 assign out = sel ? #5 a : #5 b;
 endmodule
