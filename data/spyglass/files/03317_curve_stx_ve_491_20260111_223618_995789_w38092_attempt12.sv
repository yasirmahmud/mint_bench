module curve_stx_ve_491_20260111_223618_995789_w38092_attempt12 (
  input wire [15:0] data_in,
  output wire [7:0] data_out
);

  // The 'data_in' is declared MSB-first as [15:0].
  // The part-select 'data_in[0:7]' uses an LSB-first style (start index 0 < end index 7).
  // SpyGlass is expected to flag this as "reversed bounds" relative to the MSB-first declaration style [15:0],
  // despite being a valid Verilog construct that concatenates bits 0 through 7.
  assign data_out = data_in[0:7];

endmodule
