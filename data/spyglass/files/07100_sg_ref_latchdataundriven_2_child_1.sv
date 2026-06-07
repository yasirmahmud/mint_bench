module latch_undriven_ex2(input enable, input d, output reg q);
 always @(enable or d) begin
  if (enable)
   q <= d;
  // Implicit else: q retains its value, forming a latch.
 end
endmodule
