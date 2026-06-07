module curve_synth_5255_20260111_024306_attempt4 (
  input [7:0] input_data_byte, // An 8-bit input to demonstrate the issue
  output out_illegal_bit      // Output to receive the out-of-range bit select
);

  // This line directly triggers SYNTH_5255.
  // 'input_data_byte' is an 8-bit signal with range [7:0].
  // Attempting to select bit 31 is explicitly out of this declared range.
  assign out_illegal_bit = input_data_byte[31];

endmodule
