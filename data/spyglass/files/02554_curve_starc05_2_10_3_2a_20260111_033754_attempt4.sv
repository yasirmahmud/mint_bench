module curve_starc05_2_10_3_2a_20260111_033754_attempt4 (
  input wire wr_en_in,        // 1 bit
  input wire [4:0] rd_addr_in, // 5 bits
  output wire out_flag
);

  // STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'.
  // This rule specifically targets the bit-width mismatch for logical AND.
  // 'wr_en_in' has a width of 1 bit.
  // 'rd_addr_in' has a width of 5 bits.
  // The widths (1 and 5) are different, triggering STARC05-2.10.3.2a.
  assign out_flag = wr_en_in && rd_addr_in;

endmodule
