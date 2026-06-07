module curve_stx_ve_418_20260110_164427_attempt10 (
  input  in_signal
);
  // SpyGlass W240 violation fix: Input 'in_signal' declared but not read.
  // Assign to a dummy wire to ensure it is read without altering functional behavior.
  wire unused_in_signal_read;
  assign unused_in_signal_read = in_signal;

endmodule
