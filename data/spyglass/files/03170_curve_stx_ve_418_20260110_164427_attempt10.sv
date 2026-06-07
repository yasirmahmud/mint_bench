module curve_stx_ve_418_20260110_164427_attempt10 (
  input  in_signal
);

  // STX_VE_418 violation: 'in_signal' is an input port and therefore not driven by a gate output within this module.
  // The rule flags paths where the source is not a gate output.
  specify
    (in_signal => in_signal) = 1;
  endspecify

endmodule
