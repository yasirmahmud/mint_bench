module curve_w392_20260111_003159_attempt3 (
  input wire clk_i,
  input wire sys_rst_i,      // A generic system reset signal
  input wire data_in_i,
  output reg q_async_high_o,
  output reg q_sync_low_o
);

// To resolve STARC05-1.3.1.3, create a distinct and synchronous signal for the synchronous reset path.
// The original 'wire sys_rst_sync_n = sys_rst_i;' was not sufficient as it was a direct alias.

// The functional behavior requires:
// 1. q_async_high_o: Asynchronous active-high reset from sys_rst_i. Resets when sys_rst_i is HIGH.
// 2. q_sync_low_o: Synchronous reset. The original code's condition was `if (!sys_rst_sync_n)`
//    where `sys_rst_sync_n` was `sys_rst_i`. So, `q_sync_low_o` resets when `sys_rst_i` is LOW, synchronously.

// Generate a distinct, synchronous signal that is HIGH when `sys_rst_i` is LOW (to match the reset condition).
// This signal (`sync_reset_cond_q_low`) will be synchronous to `clk_i` and captures the `!sys_rst_i` behavior.
reg sync_reset_cond_q_low;

always @(posedge clk_i) begin
  // When sys_rst_i is LOW, we want sync_reset_cond_q_low to become HIGH, synchronously.
  // When sys_rst_i is HIGH, we want sync_reset_cond_q_low to become LOW, synchronously.
  sync_reset_cond_q_low <= !sys_rst_i;
end

// This block interprets 'sys_rst_i' as an asynchronous active-high reset
always @(posedge clk_i or posedge sys_rst_i) begin
  if (sys_rst_i) begin // Resets when sys_rst_i is high
    q_async_high_o <= 1'b0;
  end else begin
    q_async_high_o <= data_in_i;
  end
end

// This block now uses the distinct and synchronous 'sync_reset_cond_q_low' for its reset condition.
// The condition for reset is `if (sync_reset_cond_q_low)`, which becomes true when `sys_rst_i` is low.
always @(posedge clk_i) begin
  if (sync_reset_cond_q_low) begin // Resets when sync_reset_cond_q_low is high (meaning sys_rst_i was low, synchronously)
    q_sync_low_o <= 1'b0;
  end else begin
    q_sync_low_o <= q_async_high_o; // Used to avoid unused signal warnings
  end
end

endmodule
