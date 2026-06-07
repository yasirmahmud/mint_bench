// Helper module (defined in the same file)
module full_adder (
  input wire a,
  input wire b,
  input wire cin,
  output wire sum,
  output wire carry
);
  assign sum = a ^ b ^ cin;
  assign carry = (a & b) | (cin & (a ^ b));
endmodule
