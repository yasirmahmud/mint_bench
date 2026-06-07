module my_loop_ex2(input in_a, output out_b);
 wire w1;
 assign w1 = in_a & out_b;
 assign out_b = w1;
 endmodule
