module curve_wrn_59_20260111_174738_224315_w36056_attempt10;
  wire target_net;

  initial begin
    // WRN_59: System function ($countdrivers) specified when a system task was expected.
    // System functions return values and should typically be part of an expression
    // or assignment, not a standalone statement like a system task.
    $countdrivers(target_net);
  end

endmodule
