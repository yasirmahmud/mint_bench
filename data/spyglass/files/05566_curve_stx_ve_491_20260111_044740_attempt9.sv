module curve_stx_ve_491_20260111_044740_attempt9 (
  input wire [7:0] data_in,
  output wire [2:0] part_out
);

  // This Verilog-2001 module is designed to trigger STX_VE_491.
  // The rule description states: "Bounds of part-select (...) are reversed,"
  // "usage is [2:4] whereas declaration is [7:0]".
  //
  // A vector declared with a [MSB:LSB] range (e.g., data_in[7:0]) expects
  // part-selects to be specified as [high_index:low_index], where high_index >= low_index.
  //
  // By using `data_in[2:4]`, we are specifying a part-select where the MSB index (2)
  // is less than the LSB index (4), which is inconsistent with the `[7:0]` declaration
  // direction. This direct contradiction of the declared vector's bit ordering
  // is precisely what SpyGlass is expected to flag as "reversed bounds" with a
  // "usage is [2:4] whereas declaration is [7:0]" message.
  assign part_out = data_in[2:4];

endmodule
