module curve_synth_5264_20260111_215137_159414_w15680_attempt17 (
  output real out_real_value
);
  // The 'real' net type for a port is not supported in RTL synthesis,
  // triggering SYNTH_5264. The output is assigned a constant to ensure
  // it is used and avoid unused signal warnings.
  assign out_real_value = 0.5;
endmodule
