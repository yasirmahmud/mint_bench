module sim_race02_ex2(input a, input b, output reg my_sig);
 always @* begin
  // When multiple assignments to the same signal occur within a single always block
  // in a combinational context, the last assignment takes precedence.
  // To resolve the W415a violation, the redundant assignment 'my_sig = a' has been removed,
  // as its value was always overridden by 'my_sig = b'.
  my_sig = b;
 end
endmodule
