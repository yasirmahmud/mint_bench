module checkMultipleDrivers_ex2 (input a, b, output c);
 wire w;
 assign w = a;
 assign w = b;
 assign c = w;
 endmodule
