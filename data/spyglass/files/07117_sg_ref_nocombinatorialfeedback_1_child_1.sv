module loop_ex1(input in1, output reg out1);
  // Original behavior: assign out1 = in1 & out1;
  // If in1 is 0, out1 becomes 0. (0 & out1 = 0)
  // If in1 is 1, out1 becomes out1. (1 & out1 = out1), implying a latching behavior.
  // This solution infers a latch to preserve the implied functional behavior
  // while resolving the combinatorial loop violation.
  always @* begin
    if (in1 == 1'b0) begin
      out1 = 1'b0;
    end
    // If in1 is 1, out1 retains its current value, inferring a latch.
  end
endmodule
