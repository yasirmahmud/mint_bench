module curve_wrn_59_20260110_135421_attempt1;
  reg my_signal;

  initial begin
    $countdrivers(my_signal); // WRN_59: System function specified when a system task was expected
  end
endmodule
