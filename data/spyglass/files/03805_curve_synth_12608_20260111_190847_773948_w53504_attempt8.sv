module curve_synth_12608_20260111_190847_773948_w53504_attempt8 (
    input wire a,
    input wire b,
    output reg q
);

  // According to rule examples (e.g., Example 2 from context),
  // the SYNTH_12608 violation is triggered when an `always_latch` block
  // is used, but the logic inside it does not actually infer a latch.
  // Instead, the logic infers a combinatorial assignment.
  // This constitutes a "mismatch" between the explicit block type (`always_latch`)
  // and the actual inferred logic (combinatorial).
  always_latch begin
    // This is a purely combinatorial assignment.
    // 'q' is always assigned a value based on 'a' and 'b' inputs in every simulation cycle,
    // thus no latching behavior is inferred from the logic itself.
    q = a & b;
  end

endmodule
