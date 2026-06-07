module cond_sig_delay_ex2 (input sel, input a, input b, output out);
 assign #5 out = sel ? a : b;
 endmodule
