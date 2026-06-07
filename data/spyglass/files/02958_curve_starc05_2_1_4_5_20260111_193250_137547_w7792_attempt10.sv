module curve_starc05_2_1_4_5_20260111_193250_137547_w7792_attempt10 (
  input [2:0] data_val_a,
  input [2:0] data_val_b,
  output logical_out
);

  // STARC05-2.1.4.5: Using logical AND (&&) with multi-bit operands 'data_val_a' and 'data_val_b'
  assign logical_out = data_val_a && data_val_b;

endmodule
