module curve_wrn_59_20260110_135421_attempt2;
  reg my_signal;

  initial begin
    // WRN_59: System function ($countdrivers) specified when a system task was expected
    $countdrivers(my_signal);
  end
endmodule
