module curve_stx_ve_491_20260111_223618_995789_w38092_attempt11 (
  input wire [10:0] data_in,
  output wire [4:0] data_out
);

  // The 'data_in' is declared MSB-first as [10:0].
  // The part-select 'data_in[3:7]' uses an LSB-first style (start index 3 < end index 7).
  // SpyGlass flags this as "reversed bounds" relative to the MSB-first declaration style [10:0],
  // despite being a valid Verilog construct.
  assign data_out = data_in[3:7];

endmodule
