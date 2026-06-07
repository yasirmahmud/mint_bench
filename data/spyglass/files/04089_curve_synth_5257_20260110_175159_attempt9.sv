module curve_synth_5257_20260110_175159_attempt9 (
  input [0:0] data_in,      // A 1-bit input vector with range [0:0]
  output wire data_out_0,   // Output to use the valid bit data_in[0]
  output wire data_out_error// Output that triggers the part-select error
);

  // Assign data_in[0] to data_out_0. This uses the valid bit of the input vector
  // and prevents a W240 (unused input bit) warning.
  assign data_out_0 = data_in[0];

  // SYNTH_5257: Part Select [1:1] on a Vector data_in[0:0] is out of range
  // The input vector 'data_in' is declared as [0:0], meaning it has only one bit at index 0.
  // Attempting to access data_in[1:1] is an out-of-bounds part-select, as bit 1 does not exist.
  // This directly triggers the SYNTH_5257 rule.
  assign data_out_error = data_in[1:1];

endmodule
