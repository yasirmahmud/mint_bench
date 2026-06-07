module curve_wrn_59_20260110_135421_attempt4;
  reg my_data_signal;

  // WRN_59: System function ($countdrivers) specified when a system task was expected in this context
  always @(posedge my_data_signal) begin
    $countdrivers(my_data_signal);
  end

endmodule
