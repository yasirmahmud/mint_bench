module curve_starc05_2_10_3_2a_20260111_033754_attempt1 (
  input [0:0] en_in,
  input [4:0] addr_in,
  output out_flag
);

  assign out_flag = en_in && addr_in;

endmodule
