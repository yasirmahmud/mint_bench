module similar_rtl_ex2(input a, b, c, d, output y, z);
 wire w1, w2;
 assign w1 = a;
 assign w1 = b;
 assign w2 = c;
 assign w2 = d;
 assign y = w1;
 assign y = c;
 assign z = w2;
 assign z = a;
 endmodule
