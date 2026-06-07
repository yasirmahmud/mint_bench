module curve_latchfeedback_20260111_200604_968565_w36056_attempt8 (
  input wire enable,
  input wire data_in,
  output reg q_out
);

  reg feedback_latch; // This reg will form a latch

  // Level-sensitive always block describing a latch.
  // The explicit 'else' branch aims to avoid an 'InferLatch' violation
  // by explicitly stating that the latch holds its value.
  always @(enable or data_in or feedback_latch) begin
    if (enable) begin
      // Feedback loop: 'feedback_latch' is used on the RHS to determine its next value.
      // This combinational feedback within the level-sensitive block triggers LatchFeedback.
      feedback_latch = data_in ^ feedback_latch;
    end else begin
      // Explicitly hold the current value to prevent an implicit latch inference
      // and hopefully avoid the InferLatch rule, while still defining a latch.
      feedback_latch = feedback_latch;
    end
  end

  assign q_out = feedback_latch;

endmodule
