module curve_wrn_59_20260110_191304_attempt6;
  wire data_line;

  // Drive the signal to ensure it's not unused and has a driver
  assign data_line = 1'b0;

  initial begin
    // WRN_59: System function ($countdrivers) specified when a system task was expected
    // The return value of $countdrivers is ignored here.
    $countdrivers(data_line);
  end

endmodule
