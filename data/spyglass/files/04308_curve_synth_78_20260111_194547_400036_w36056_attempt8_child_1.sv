module curve_synth_78_20260111_194547_400036_w36056_attempt8 (
  input wire input_a,
  input wire input_b,
  output reg output_c
);

  // The original 'always' block contained a non-synthesizable 'wait' construct.
  // According to the SpyGlass violation description and general synthesis behavior,
  // 'wait' constructs are ignored by synthesis tools, and subsequent assignments
  // are synthesized as if the 'wait' was not present.
  // To resolve the SYNTH_78 violation and preserve the functional behavior as
  // it would be derived by a synthesis tool (i.e., ignoring the 'wait'),
  // the 'wait' statement has been removed.
  always @(*) begin
    if (input_a) begin
      output_c = 1'b1;
    end else begin
      output_c = 1'b0;
    end
  end

endmodule
