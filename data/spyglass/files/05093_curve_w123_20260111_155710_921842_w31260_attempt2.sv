module curve_w123_20260111_155710_921842_w31260_attempt2 (
  input wire in_bit,
  output wire out_bit
);

  // W123: "Signal 'Q[1823]' size too big thus not processed"
  // The rule description uses 'Q[1823]' as an example of a problematic signal size.
  // Previous attempt using 'wire [1823:0]' did not trigger the violation,
  // suggesting that the actual threshold for "too big" is significantly higher
  // than 1824 bits (the width of a bus with MSB 1823).
  //
  // To ensure triggering, this example declares an extremely wide bus (150,000 bits).
  // This width should comfortably exceed any internal processing limits SpyGlass might have,
  // leading to the "size too big" violation.
  // The bus name 'Q_extremely_wide_bus' is chosen to reflect the 'Q' in the rule description's example.
  wire [149999:0] Q_extremely_wide_bus;

  // Assign a value to the wide bus to ensure it is considered used and processed by the tool.
  // This also prevents 'unused input' for 'in_bit' and avoids latches.
  assign Q_extremely_wide_bus = {149999'b0, in_bit};

  // Assign a bit from the wide bus to the output to prevent 'unused signal'
  // for 'Q_extremely_wide_bus' and 'unconnected output' for 'out_bit'.
  assign out_bit = Q_extremely_wide_bus[0];

endmodule
