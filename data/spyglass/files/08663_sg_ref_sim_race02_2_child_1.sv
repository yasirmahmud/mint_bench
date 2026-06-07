module sim_race02_ex2(input a, input b, output reg my_sig);
 always @* begin
  // When multiple assignments to the same signal occur within a single always block
  // in a combinational context, the last assignment takes precedence.
  // This resolves the multiple driver issue by making 'my_sig' deterministically driven.
  my_sig = a;
  my_sig = b;
 end
endmodule
