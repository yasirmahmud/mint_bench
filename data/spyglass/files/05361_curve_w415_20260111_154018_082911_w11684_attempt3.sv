module curve_w415_20260111_154018_082911_w11684_attempt3 (
  input wire in_a,
  input wire in_b,
  output wire out_sig
);

  // The signal 'out_sig' is driven by 'in_a'.
  assign out_sig = in_a;

  // The signal 'out_sig' is also simultaneously driven by 'in_b',
  // leading to multiple drivers for the same wire, which triggers W415.
  assign out_sig = in_b;

endmodule
