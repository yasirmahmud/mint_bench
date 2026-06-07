module curve_wrn_33_20260111_184522_536302_w37940_attempt9 (
  input wire top_in_a,
  input wire top_in_b,
  output wire top_out_c
);
  wire internal_c;

  // WRN_33: Module instance name not specified
  child_module (
    .in_a(top_in_a),
    .in_b(top_in_b),
    .out_c(internal_c)
  );

  assign top_out_c = internal_c;
endmodule
