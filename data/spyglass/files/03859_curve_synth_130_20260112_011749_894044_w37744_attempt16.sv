module curve_synth_130_20260112_011749_894044_w37744_attempt16 (
    input wire in_data_bit0,
    input wire in_data_bit1,
    input wire ctrl_enable_a,
    input wire ctrl_enable_b,
    output wire out_path0,
    output wire out_path1,
    output wire out_path2,
    output wire out_path3,
    output wire out_path4
);

  // Each nmos instance below will trigger a SYNTH_130 violation (nmos gate types are not supported)
  nmos nmos_inst_0 (out_path0, in_data_bit0, ctrl_enable_a);
  nmos nmos_inst_1 (out_path1, in_data_bit1, ctrl_enable_b);
  nmos nmos_inst_2 (out_path2, in_data_bit0, 1'b1);
  nmos nmos_inst_3 (out_path3, 1'b0, ctrl_enable_a);
  nmos nmos_inst_4 (out_path4, in_data_bit1, ctrl_enable_a);

endmodule
