module overlapping_loops_ex1;
 wire a, b, c, d, e;
 assign a = c;
 assign b = a;
 assign c = 1'b0; // Fixed multiple drivers and first combinational loop
 assign d = c;
 assign e = d;
 // assign c = e; // Removed to fix multiple drivers and second combinational loop
 endmodule
