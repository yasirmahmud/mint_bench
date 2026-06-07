module curve_stx_ve_418_20260110_113444_attempt4 ();

  // Declare a wire that is not driven by any 'gate output' within this module.
  // This ensures it meets the criteria for STX_VE_418.
  wire undriven_signal;

  // STX_VE_418: Path ( undriven_signal ) is not valid, because it is not driven by a gate output
  // 'undriven_signal' is a wire that has no driver, thus not driven by a gate output.
  specify
    (undriven_signal => undriven_signal) = 1;
  endspecify

endmodule
