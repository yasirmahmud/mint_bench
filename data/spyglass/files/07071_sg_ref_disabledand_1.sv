module disabled_and_ex1();
 wire b_in, out_q;
 assign b_in = 1'b1;
 and g1 (out_q, 1'b0, b_in);
 endmodule
