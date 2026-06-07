module curve_synth_5338_20260111_180415_236091_w36056_attempt9 (
  input [3:0] base_val,
  output wire [11:0] result
);

  // SYNTH_5338: Exponentiation is supported only if the base is a power of 2 or the exponent is 0,1,or 2.
  // Here, the exponent (3) is not 0, 1, or 2. The base (base_val) is an input and therefore not guaranteed to be a power of 2.
  assign result = base_val ** 3;

endmodule
