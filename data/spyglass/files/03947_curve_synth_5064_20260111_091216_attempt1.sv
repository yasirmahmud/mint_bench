module curve_synth_5064_20260111_091216_attempt1 ();

  // SYNTH_5064: Immediate assertions are generally not synthesizable.
  // Although the rule description mentions "COVER statements", the provided
  // context examples show 'assert' statements triggering this rule.
  // This construct should trigger exactly one SYNTH_5064 violation.
  always @* begin
    assert(1);
  end

endmodule
