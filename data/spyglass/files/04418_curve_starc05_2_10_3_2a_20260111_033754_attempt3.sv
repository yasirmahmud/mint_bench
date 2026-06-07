module curve_starc05_2_10_3_2a_20260111_033754_attempt3 (
  output out_result
);

  // STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'.
  // The logical AND operator '&&' is applied to two constant operands:
  // '8'hAA' which has a width of 8 bits, and '1'b1' which has a width of 1 bit.
  // This direct mismatch in operand widths for '&&' triggers STARC05-2.10.3.2a.
  assign out_result = 8'hAA && 1'b1;

endmodule
