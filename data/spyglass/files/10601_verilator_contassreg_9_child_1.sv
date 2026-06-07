module test9(input a, input b);
  wire or_reg; // Changed from 'reg' to 'wire' to fix CONTASSREG violation as described
  assign or_reg = a | b;
endmodule
