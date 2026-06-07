`timescale 1ns/1ps

// Definition of the full_adder module to resolve ErrorAnalyzeBBox violation
module full_adder(input a, b, cin, output sum, cout);
  wire s_int;
  wire c_int1, c_int2;

  // Sum = a XOR b XOR cin
  xor (s_int, a, b);
  xor (sum, s_int, cin);

  // Cout = (a AND b) OR (cin AND (a XOR b))
  and (c_int1, a, b);
  and (c_int2, cin, s_int);
  or (cout, c_int1, c_int2);
endmodule
