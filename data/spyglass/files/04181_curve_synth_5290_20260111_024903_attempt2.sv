module curve_synth_5290_20260111_024903_attempt2 (
  input wire enable_in,
  output wire result_out
);

  // Declare a 'real' variable. Variables of type 'real' are generally not synthesizable.
  real my_real_variable;

  // This combinational assignment uses a 'real' variable in a comparison.
  // The usage of 'my_real_variable' in a synthesizable context is expected to trigger SYNTH_5290.
  // The 'enable_in' port is used to avoid an unused signal warning.
  assign result_out = (my_real_variable > 1.0) ? enable_in : 1'b0;

endmodule
