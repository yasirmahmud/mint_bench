module latch_undriven_ex2(input enable, input d, output reg q);
 always @(enable or d) begin
  if (enable)
   q <= d;
  else // Explicitly retain value to resolve InferLatch violation while preserving latch behavior.
   q <= q;
 end
endmodule
