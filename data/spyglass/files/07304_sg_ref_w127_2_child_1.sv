module W127_ex2;
 wire a; // Changed from reg to wire to resolve W127
 reg b;
 assign #1 a = b; // Fixed syntax error #1'bx to #1
 endmodule
