module curve_synth_5255_20260111_024306_attempt3 (
  input [7:0] data_in_8bit, // 8-bit input to provide data
  output out_bit_value      // Single bit output to receive the illegal bit select
);

  // Declare an 8-bit wire. The rule's description mentions 'Ct' as 8-bit wide.
  wire [7:0] my_signal_8bit;

  // Drive the 8-bit wire from the input to ensure it's used and to avoid unused signal warnings.
  assign my_signal_8bit = data_in_8bit;

  // This line triggers SYNTH_5255: attempting to access bit 31 of an 8-bit wire (my_signal_8bit).
  // The index 31 is far out of the declared range [7:0].
  assign out_bit_value = my_signal_8bit[31];

endmodule
