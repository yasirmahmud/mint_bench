module overlapping_loops_ex1;
 wire a, c, d;
 assign a = c;
 assign c = 1'b0;
 assign d = c;
 endmodule
