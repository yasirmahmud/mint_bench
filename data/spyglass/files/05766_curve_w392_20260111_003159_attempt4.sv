module curve_w392_20260111_003159_attempt4 (
  input wire clk_i,
  input wire rst_i,      // Reset signal used with conflicting polarities
  input wire data_i,
  output reg q_active_high_rst_o,
  output reg q_active_low_rst_o
);

// This block uses 'rst_i' as an asynchronous active-high reset
always @(posedge clk_i or posedge rst_i) begin
  if (rst_i) begin // 'rst_i' causes reset when high
    q_active_high_rst_o <= 1'b0;
  end else begin
    q_active_high_rst_o <= data_i;
  end
end

// This block uses 'rst_i' as an asynchronous active-low reset
// This usage with 'negedge rst_i' and 'if (!rst_i)' has a different polarity
// than the first block, directly triggering W392.
always @(posedge clk_i or negedge rst_i) begin
  if (!rst_i) begin // 'rst_i' causes reset when low
    q_active_low_rst_o <= 1'b1; // Reset to a different value to ensure distinctness
  end else begin
    q_active_low_rst_o <= q_active_high_rst_o; // Use another signal to avoid unused signal warning
  end
end

endmodule
