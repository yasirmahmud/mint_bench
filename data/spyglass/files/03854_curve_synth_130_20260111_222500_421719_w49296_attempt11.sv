module curve_synth_130_20260111_222500_421719_w49296_attempt11 (
  input wire  in_source_a,
  input wire  in_source_b,
  input wire  in_gate_control_c,
  input wire  in_gate_control_d,
  output wire out_drain_x,
  output wire out_drain_y,
  output wire out_drain_z,
  output wire out_drain_w,
  output wire out_drain_v
);

  // Each nmos instance will trigger a SYNTH_130 violation (nmos gate types are not supported)
  nmos nmos_inst0 (out_drain_x, in_source_a, in_gate_control_c);
  nmos nmos_inst1 (out_drain_y, in_source_b, in_gate_control_d);
  nmos nmos_inst2 (out_drain_z, 1'b0, in_gate_control_c);
  nmos nmos_inst3 (out_drain_w, in_source_a, 1'b1);
  nmos nmos_inst4 (out_drain_v, in_source_b, in_gate_control_c);

endmodule
