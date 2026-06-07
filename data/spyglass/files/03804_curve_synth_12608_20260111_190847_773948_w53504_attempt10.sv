module curve_synth_12608_20260111_190847_773948_w53504_attempt10 (
    input wire a,
    input wire b,
    output reg q
);

  // This always_latch block describes purely combinatorial logic (q = a ^ b).
  // Since 'q' is always assigned a value, no latching behavior is inferred.
  // This mismatch between the declared block type (always_latch)
  // and the inferred logic (combinatorial) triggers SYNTH_12608.
  always_latch begin
    q = a ^ b;
  end

endmodule
