module rule_26_1_ex2 ();
 wire my_output_signal;
 AND2X1 u_gate (.I0 (1'b0), .I1 (1'b1), .Z (my_output_signal));
 endmodule
