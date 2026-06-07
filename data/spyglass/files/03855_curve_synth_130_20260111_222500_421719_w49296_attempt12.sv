module curve_synth_130_20260111_222500_421719_w49296_attempt12 (
  input wire [1:0] data_in,
  input wire [1:0] control_in,
  output wire out0,
  output wire out1,
  output wire out2,
  output wire out3,
  output wire out4
);

  // Each nmos instance will trigger a SYNTH_130 violation (nmos gate types are not supported)
  nmos g0 (out0, data_in[0], control_in[0]);
  nmos g1 (out1, data_in[1], control_in[1]);
  nmos g2 (out2, data_in[0], 1'b1);
  nmos g3 (out3, 1'b0, control_in[0]);
  nmos g4 (out4, data_in[1], control_in[0]);

endmodule
