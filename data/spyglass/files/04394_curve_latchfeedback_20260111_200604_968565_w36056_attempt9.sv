module curve_latchfeedback_20260111_200604_968565_w36056_attempt9 (
  input wire enable,
  input wire data_in,
  output reg q_out
);

  reg [2:0] my_latch_reg;
  wire [2:0] M;

  // M is derived from data_in, ensuring its width matches my_latch_reg for the subtraction.
  // Using concatenation to extend single bit 'data_in' to 3 bits.
  assign M = {data_in, data_in, data_in};

  // Level-sensitive always block describing a latch.
  // The latch is explicitly defined by the conditional assignment
  // and the explicit 'else' branch to hold its value.
  always @(enable or M or my_latch_reg) begin
    if (enable) begin
      // This line creates the feedback. my_latch_reg's next value
      // depends on its current value (my_latch_reg on RHS) and M.
      // This forms a combinational feedback loop within the latch definition,
      // which should specifically trigger the LatchFeedback rule, as seen in the context examples.
      my_latch_reg = my_latch_reg - M;
    end else begin
      // Explicitly hold the current value to prevent an implicit latch inference
      // and avoid the InferLatch rule.
      my_latch_reg = my_latch_reg;
    end
  end

  // Assign one bit of the latch output to q_out to avoid unused signal warnings for my_latch_reg
  assign q_out = my_latch_reg[0];

endmodule
