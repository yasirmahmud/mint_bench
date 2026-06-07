module curve_w392_20260111_182843_915337_w53504_attempt10 (
  input wire clk,
  input wire rst, // This reset signal will be used with mixed polarities
  input wire data_a,
  input wire data_b,
  output reg q_reg_a,
  output reg q_reg_b
);

  // First flip-flop: Configured for active-low asynchronous reset
  // The 'rst' signal is sensitive to its negedge in the sensitivity list,
  // and its low state is checked for the reset condition.
  always @(posedge clk or negedge rst) begin
    if (!rst) begin // Active-low reset condition
      q_reg_a <= 1'b1; // Reset to 1
    end else begin
      q_reg_a <= data_a;
    end
  end

  // Second flip-flop: Configured for active-high asynchronous reset
  // The *same* 'rst' signal is sensitive to its posedge in the sensitivity list,
  // and its high state is checked for the reset condition.
  // This usage with a different polarity interpretation for the same reset signal
  // (rst) across different always blocks triggers the W392 violation.
  always @(posedge clk or posedge rst) begin
    if (rst) begin // Active-high reset condition
      q_reg_b <= 1'b0; // Reset to 0
    end else begin
      q_reg_b <= data_b;
    end
  end

endmodule
