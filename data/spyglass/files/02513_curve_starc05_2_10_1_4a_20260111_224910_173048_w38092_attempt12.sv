module curve_starc05_2_10_1_4a_20260111_224910_173048_w38092_attempt12 (
  input wire test_signal,
  output wire z_detected
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // This direct comparison of a signal with 1'bz explicitly triggers the target rule.
  assign z_detected = (test_signal === 1'bz);

endmodule
