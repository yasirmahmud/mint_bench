module overlapping_loops_ex1;
 wire a, b, c, d, e;
 assign a = c;
 assign b = a;
 assign c = b;
 assign d = c;
 assign e = d;
 assign c = e;
 endmodule
