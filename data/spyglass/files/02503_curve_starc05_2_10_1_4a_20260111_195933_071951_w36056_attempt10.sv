module curve_starc05_2_10_1_4a_20260111_195933_071951_w36056_attempt10 (
  input wire check_signal,
  output wire z_detected
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // This directly targets the rule by comparing a single-bit signal with 1'bz.
  // This is expected to trigger STARC05-2.10.1.4a.
  //
  // Based on previous attempts and context examples, triggering *only* STARC05-2.10.1.4a is challenging:
  // 1. STARC05-2.10.1.4b (Signal compared with value containing x or z) is a broader rule that typically triggers alongside 4a
  //    when comparing with 1'bz (since 1'bz contains 'z'). It is hoped that the lint tool might prioritize or suppress 4b if 4a
  //    (more specific for 'z') is triggered for the same comparison.
  // 2. W339a (Operator '===' should be avoided in synthesis logic): Using the '===' operator in synthesizable code
  //    (like an 'assign' statement or an 'always' block) commonly triggers W339a. This operator is essential for detecting
  //    'z' states explicitly.
  assign z_detected = (check_signal === 1'bz);

endmodule
