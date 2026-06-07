module sim_loop01_ex2 (input in1, output out1);
 wire w1, w2;
 always @(in1 or w2) w1 = in1 ^ w2;
 assign w2 = w1;
 assign out1 = w1;
 endmodule
