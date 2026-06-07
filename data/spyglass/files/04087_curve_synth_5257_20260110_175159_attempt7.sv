module curve_synth_5257_20260110_175159_attempt7 (
  input [0:0] in_data, // A 1-bit input vector with range [0:0]
  output wire out_sig  // Output signal, will receive the part-selected value
);

  // SYNTH_5257: Part Select [1:1] on a Vector in_data[0:0] is out of range
  // The vector 'in_data' is declared with a width of 1 (range [0:0]).
  // The part-select [1:1] attempts to access bits beyond its declared bounds.
  assign out_sig = in_data[1:1];

endmodule
