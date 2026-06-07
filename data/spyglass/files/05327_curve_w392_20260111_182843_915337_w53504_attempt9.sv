module curve_w392_20260111_182843_915337_w53504_attempt9 (
  input wire clk_i,
  input wire rst_i, // Reset signal causing W392 violation
  input wire data_in,
  output reg q_out_al, // Output for active-low reset logic
  output reg q_out_ah  // Output for active-high reset logic
);

  // First flip-flop with active-low asynchronous reset
  // The 'rst_i' signal is sampled on negedge, and checked for !rst_i.
  always @(posedge clk_i or negedge rst_i) begin
    if (!rst_i) begin // Active-low reset condition
      q_out_al <= 1'b0; // Reset to 0
    end else begin
      q_out_al <= data_in;
    end
  end

  // Second flip-flop with active-high asynchronous reset
  // The *same* 'rst_i' signal is sampled on posedge, and checked for rst_i.
  // This usage with a different polarity for the same reset signal triggers W392.
  always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin // Active-high reset condition
      q_out_ah <= 1'b1; // Reset to 1 (distinct reset value)
    end else begin
      q_out_ah <= ~data_in; // Distinct data path logic
    end
  end

endmodule
