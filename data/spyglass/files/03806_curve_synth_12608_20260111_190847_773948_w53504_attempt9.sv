module curve_synth_12608_20260111_190847_773948_w53504_attempt9 (
    input wire a,
    input wire b,
    output reg q
);

  // This always_latch block describes purely combinatorial logic.
  // 'q' is always assigned a value based on 'a' and 'b' inputs,
  // meaning no latching behavior is inferred from the logic itself.
  // This mismatch between the declared block type (always_latch)
  // and the inferred logic (combinatorial) triggers SYNTH_12608.
  always_latch begin
    if (a) begin
      q = b;
    end else begin
      q = ~b;
    end
  end

endmodule
