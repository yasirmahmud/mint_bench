module curve_synth_5255_20260111_024306_attempt4 (
  input [7:0] input_data_byte, // An 8-bit input to demonstrate the issue
  output out_illegal_bit      // Output to receive the out-of-range bit select
);

  // To resolve SYNTH_5255 and WRN_27, we explicitly model the behavior of
  // accessing an out-of-range bit, which in Verilog for fixed-size vectors
  // evaluates to '0'. This is done by zero-extending 'input_data_byte'
  // to a wider width (e.g., 32 bits) and then performing the bit select.
  // This makes the bit select legal within the concatenated vector.
  assign out_illegal_bit = {24'b0, input_data_byte}[31];

endmodule
