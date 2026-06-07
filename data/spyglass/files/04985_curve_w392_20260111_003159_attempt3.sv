module curve_w392_20260111_003159_attempt3 (
  input wire clk_i,
  input wire sys_rst_i,      // A generic system reset signal
  input wire data_in_i,
  output reg q_async_high_o,
  output reg q_sync_low_o
);

// This block interprets 'sys_rst_i' as an asynchronous active-high reset
always @(posedge clk_i or posedge sys_rst_i) begin
  if (sys_rst_i) begin // Resets when sys_rst_i is high
    q_async_high_o <= 1'b0;
  end else begin
    q_async_high_o <= data_in_i;
  end
end

// This block interprets 'sys_rst_i' as a synchronous active-low reset
// This constitutes a different polarity usage for the same reset signal 'sys_rst_i'
always @(posedge clk_i) begin
  if (!sys_rst_i) begin // Resets when sys_rst_i is low
    q_sync_low_o <= 1'b0;
  end else begin
    q_sync_low_o <= q_async_high_o; // Used to avoid unused signal warnings
  end
end

endmodule
