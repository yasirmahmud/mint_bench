module curve_w123_20260111_155710_921842_w31260_attempt9 (
  input wire in_a,
  output wire out_b
);

  // Declare 'Q' with a size sufficient to cover the highest indexed bit accessed (1823).
  // This resolves the W123 violation by avoiding an excessively large bus that triggers
  // the "size too big" error, while preserving the functional behavior.
  wire [1823:0] Q;

  // Drive a single bit of 'Q'.
  assign Q[0] = in_a;

  // Access the specific bit 'Q[1823]'.
  // Since Q[1823] is not driven anywhere in the module, its value will default to 'z',
  // making 'out_b' functionally 'z', which matches the original behavior.
  assign out_b = Q[1823];

endmodule
