module curve_synth_5255_20260111_024306_attempt5 (
  input [7:0] data_byte, // An 8-bit input, range [7:0]
  output illegal_output, // Output to receive the out-of-range bit select
  output legal_output    // Output to demonstrate a legal use of data_byte and avoid W240
);

  // This line triggers SYNTH_5255: Illegal bit select.
  // 'data_byte' is declared as [7:0], so accessing index 31 is out of range.
  assign illegal_output = data_byte[31];

  // This line ensures 'data_byte' is also used legally, preventing a W240 warning (input not read).
  assign legal_output = data_byte[0];

endmodule
