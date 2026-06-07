module curve_synth_130_20260112_011749_894044_w37744_attempt15 (
    input logic_input_a,
    input logic_input_b,
    input control_signal_x,
    input control_signal_y,
    output wire output_stage_0,
    output wire output_stage_1,
    output wire output_stage_2,
    output wire output_stage_3,
    output wire output_stage_4
);

  // Each nmos instance below will trigger a SYNTH_130 violation (nmos gate types are not supported)
  nmos nmos_unit_0 (output_stage_0, logic_input_a, control_signal_x);
  nmos nmos_unit_1 (output_stage_1, logic_input_b, control_signal_y);
  nmos nmos_unit_2 (output_stage_2, logic_input_a, control_signal_y);
  nmos nmos_unit_3 (output_stage_3, 1'b0, control_signal_x);
  nmos nmos_unit_4 (output_stage_4, logic_input_b, 1'b1);

endmodule
