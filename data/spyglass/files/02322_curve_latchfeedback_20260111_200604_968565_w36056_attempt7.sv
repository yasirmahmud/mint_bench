module curve_latchfeedback_20260111_200604_968565_w36056_attempt7 (
  input wire enable,
  input wire data_in,
  output reg q_out
);

  reg latch_data; // This 'reg' will infer a latch

  // Latch inference: 'latch_data' is not assigned when 'enable' is low
  // Feedback: 'latch_data' on RHS feeds back into its own assignment
  always @(enable or data_in or latch_data) begin
    if (enable) begin
      latch_data = data_in ^ latch_data; // Feedback from 'latch_data' to its input
    end
    // 'latch_data' retains its value when 'enable' is low, inferring a latch.
  end

  assign q_out = latch_data;

endmodule
