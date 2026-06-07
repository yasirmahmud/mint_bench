module curve_starc05_2_10_1_4a_20260111_224910_173048_w38092_attempt12 (
  input wire test_signal,
  output wire z_detected
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // This direct comparison of a signal with 1'bz explicitly triggers the target rule.
  // Fix: Use `ifdef SYNTHESIS` to remove non-synthesizable 'z' comparison for synthesis.
  // In synthesis, a 'z' state for an internal logic signal is not typically representable or detectable,
  // therefore `z_detected` is forced to 0 to ensure synthesizability and avoid violations.
  // The original behavior is preserved for simulation when `SYNTHESIS` is not defined.
`ifdef SYNTHESIS
  assign z_detected = 1'b0;
`else
  assign z_detected = (test_signal === 1'bz);
`endif

endmodule
