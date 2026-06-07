module math_unit (
  input  a,
  input  b,
  output sum_out,
  output carry_out
);
  assign sum_out   = a ^ b;
  assign carry_out = a & b;
endmodule
