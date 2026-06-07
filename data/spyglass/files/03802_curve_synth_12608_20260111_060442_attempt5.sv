module curve_synth_12608_20260111_060442_attempt5 (
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
  //
  // In this example, the 'always_latch' block contains a 'case' statement
  // for a 2-bit 'sel' (wide_case). All possible values for 'sel' (2'b00, 2'b01, 2'b10, 2'b11)
  // are explicitly covered, making the logic purely combinational.
  // Importantly, the 'default' keyword is NOT used, satisfying the "no_default" aspect
  // while still ensuring all conditions are handled. This implies SpyGlass interprets
  // "no_default" as the absence of the keyword, not necessarily an incomplete case.
  //
  // SpyGlass is expected to flag this as a mismatch because 'always_latch'
  // is intended for latch inference, but the contained logic is entirely combinational.
  // This satisfies the "distinct from previous attempts" criteria as Attempt 4
  // used an *incomplete* case (inferring a latch), whereas this uses a *complete*
  // case (inferring combinational logic) without the 'default' keyword.
  always_latch begin
    case (sel)
      2'b00: out_reg = a;
      2'b01: out_reg = b;
      2'b10: out_reg = c;
      2'b11: out_reg = d;
    endcase
  end

endmodule
