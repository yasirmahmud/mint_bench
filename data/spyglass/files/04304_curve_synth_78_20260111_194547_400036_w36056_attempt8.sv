module curve_synth_78_20260111_194547_400036_w36056_attempt8 (
  input wire input_a,
  input wire input_b,
  output reg output_c
);

  // This 'always' block demonstrates a non-synthesizable 'wait' construct.
  // 'wait' is inherently sequential and event-driven, which cannot be translated
  // into static combinational or synchronous hardware logic for synthesis.
  // Placing it within an 'always @(*)' block highlights its unsynthesizable nature
  // in what would otherwise be a combinational block.
  always @(*) begin
    if (input_a) begin
      // SYNTH_78 violation: 'wait' construct is not synthesizable.
      // This statement attempts to pause execution until 'input_b' becomes high.
      // For synthesis, this construct is ignored, and subsequent assignments
      // will be synthesized as if the 'wait' was not present.
      wait (input_b == 1'b1);
      output_c = 1'b1;
    end else begin
      output_c = 1'b0;
    end
  end

endmodule
