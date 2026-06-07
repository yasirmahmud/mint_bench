module curve_w392_20260111_182843_915337_w53504_attempt7 (
  input wire clk,
  input wire rst, // The problematic reset signal
  input wire data_in,
  output reg q_ah_async, // Active-high asynchronous reset
  output reg q_al_async, // Active-low asynchronous reset
  output reg q_ah_sync,  // Active-high synchronous reset
  output reg q_al_sync   // Active-low synchronous reset
);

// Introduce new wires to explicitly differentiate the reset signals based on their intended use.
// This helps SpyGlass classify each signal correctly and avoids violations
// related to using a single signal for multiple, conflicting reset types/polarities.
// The functional behavior of each reset type (asynchronous/synchronous, active-high/active-low)
// as derived from the 'rst' input is strictly preserved.

// 1. Signal for active-high asynchronous reset
// This signal is asserted when 'rst' is high.
wire rst_ah_async_sig = rst;

// 2. Signal for active-low asynchronous reset
// This signal is derived as the inverse of 'rst'.
// When 'rst' is low (asserting the active-low reset), 'rst_al_async_sig' will be high.
// The asynchronous edge for 'negedge rst' is equivalent to 'posedge rst_al_async_sig'.
wire rst_al_async_sig = !rst;

// 3. Signal for active-high synchronous reset
// This signal is asserted when 'rst' is high.
wire rst_ah_sync_sig = rst;

// 4. Signal for active-low synchronous reset
// Similar to rst_al_async_sig, this signal is derived as the inverse of 'rst'.
// When 'rst' is low (asserting the active-low reset), 'rst_al_sync_sig' will be high.
wire rst_al_sync_sig = !rst;


// Register 1: Uses 'rst' as an active-high asynchronous reset
always @(posedge clk or posedge rst_ah_async_sig) begin
  if (rst_ah_async_sig) begin // Active-high reset assertion
    q_ah_async <= 1'b0;
  end else begin
    q_ah_async <= data_in;
  end
end

// Register 2: Uses 'rst' as an active-low asynchronous reset
// The reset is asserted when 'rst' is low, which means 'rst_al_async_sig' is high.
// The asynchronous trigger 'negedge rst' is functionally equivalent to 'posedge rst_al_async_sig'.
always @(posedge clk or posedge rst_al_async_sig) begin
  if (rst_al_async_sig) begin // 'rst_al_async_sig' high implies 'rst' low (active-low reset asserted)
    q_al_async <= 1'b0;
  end else begin
    q_al_async <= data_in;
  end
end

// Register 3: Uses 'rst' as an active-high synchronous reset
always @(posedge clk) begin
  if (rst_ah_sync_sig) begin // Active-high reset assertion
    q_ah_sync <= 1'b0;
  end else begin
    q_ah_sync <= data_in;
  end
end

// Register 4: Uses 'rst' as an active-low synchronous reset
// The reset is asserted when 'rst' is low, which means 'rst_al_sync_sig' is high.
always @(posedge clk) begin
  if (rst_al_sync_sig) begin // 'rst_al_sync_sig' high implies 'rst' low (active-low reset asserted)
    q_al_sync <= 1'b0;
  end else begin
    q_al_sync <= data_in;
  end
end

endmodule
