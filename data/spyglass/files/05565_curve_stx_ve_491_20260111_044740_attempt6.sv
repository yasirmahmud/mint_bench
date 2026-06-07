module curve_stx_ve_491_20260111_044740_attempt6 (
  input wire [7:0] data_in,
  output wire [3:0] part_out
);

  // This Verilog-2001 indexed part-select is designed to trigger STX_VE_491.
  // The rule description states: "Bounds of part-select ( data_in[2:(+4)] )
  // are reversed, usage is [2:4] whereas declaration is [7:0]".
  // This implies SpyGlass interprets `data_in[2 :+ 4]` (which selects bits
  // data_in[2], data_in[3], data_in[4], data_in[5] from an MSB-first declared
  // `[7:0]` signal) as if it were `data_in[2:4]` (LSB:MSB format) and flags
  // it as having "reversed bounds" against the MSB-first declaration style.
  assign part_out = data_in[2 :+ 4];

endmodule
