module overlapping_loops_ex2;
 wire a, b, c;
 assign a = b;
 assign c = b;
 assign b = a | c;
 endmodule
