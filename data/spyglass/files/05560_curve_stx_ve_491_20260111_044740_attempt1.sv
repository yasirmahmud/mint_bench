module curve_stx_ve_491_20260111_044740_attempt1 (
  input wire [7:0] data_in,
  output wire [3:0] part_out
);

  // This triggers STX_VE_491 as per the context example.
  // The rule description states: "Bounds of part-select ( data_in[2:(+4)] ) are reversed,
  // usage is [2:4] whereas declaration is [7:0]".
  // SpyGlass interprets the Verilog-2001 indexed part-select [start_expression :+ width_expression]
  // where the start index (2) is 'low' in a vector declared [7:0] (MSB-first),
  // leading to the bounds being considered 'reversed'.
  // Although [2 :+ 4] normally implies bits [5:2] (4 bits), the rule description's
  // mention of "usage is [2:4]" suggests a specific internal interpretation that
  // identifies the 'reversed' nature, even if the actual width selection is respected
  // for non-STX_VE_491 rule checks (as indicated by the context example having no other violations).
  assign part_out = data_in[2 :+ 4];

endmodule
