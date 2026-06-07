module curve_wrn_59_20260110_191304_attempt7 (
  input wire my_signal
);

  initial begin
    // WRN_59: System function ($countdrivers) specified when a system task was expected in this context
    // This line uses $countdrivers, which is a system function, in a context where a system task is expected.
    $countdrivers(my_signal);
  end

endmodule
