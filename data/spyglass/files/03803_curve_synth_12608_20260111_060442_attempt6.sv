module curve_synth_12608_20260111_060442_attempt6 (
  input [1:0] sel,
  input a,
  input b,
  input c,
  input d,
  output reg out_reg
);

  // SpyGlass rule SYNTH_12608 flags 'always_latch' blocks where the logic
  // inside is considered a mismatch for an 'always_latch' construct.
  // The rule description (wide_case_no_default_2) suggests a focus on
  // 'case' statements that are "wide" (multi-bit select) and "no default".
  // However, the actual violation message often indicates a mismatch
  // where the 'always_latch' block contains logic that is purely combinational
  // and should be an 'always_comb' block.
  //
  // In this example, an 'always_latch' block is used to encapsulate
  // a multi-bit 'if-else if-else' structure. This structure is a complete
  // set of conditions, meaning that the output 'out_reg' is assigned a value
  // in every possible path based on the 'sel' input.
  // This implies purely combinational logic (e.g., a 4-to-1 multiplexer).
  //
  // SpyGlass is expected to flag this as a mismatch because 'always_latch'
  // is specifically intended for latch inference, but the contained logic
  // describes a combinational circuit where no memory element (latch)
  // is implied. The tool will suggest it should be 'always_comb'.
  // This example is distinct from previous attempts that used simple 'if/else'
  // or 'case' statements, by employing a comprehensive 'if-else if-else' chain.
  always_latch begin
    if (sel == 2'b00) begin
      out_reg = a;
    end else if (sel == 2'b01) begin
      out_reg = b;
    end else if (sel == 2'b10) begin
      out_reg = c;
    end else begin // Covers sel == 2'b11
      out_reg = d;
    end
  end

endmodule
