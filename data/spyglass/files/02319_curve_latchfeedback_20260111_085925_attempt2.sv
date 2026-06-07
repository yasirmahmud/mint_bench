module curve_latchfeedback_20260111_085925_attempt2 (
  input enable_i,
  output reg latch_o
);

  always @(*) begin
    if (enable_i) begin
      latch_o = ~latch_o; // Latch inferred for latch_o, and feedback occurs.
    end
    // An 'else' branch is missing, which causes 'latch_o' to retain its value
    // when 'enable_i' is low, thus inferring a latch. The assignment
    // 'latch_o = ~latch_o;' uses the current value of the latch's output
    // ('latch_o' on the RHS) to determine its next value, creating a feedback
    // path which triggers the 'LatchFeedback' rule.
  end

endmodule
