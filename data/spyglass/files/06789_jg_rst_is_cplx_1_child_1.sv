module complex_reset_and (
  input clk,
  input rst0,
  input rst1,
  input d,
  output reg q
);

  // SpyGlass W442f violation (RST_IS_CPLX) is caused by a complex expression
  // in the asynchronous sensitivity list and reset condition. 
  // Create a dedicated wire for the combined reset signal.
  // Original behavior: q resets when !(rst0 && rst1) is true. 
  // This means q resets when (rst0 && rst1) is 0.
  // The asynchronous trigger is negedge (rst0 && rst1).
  // If we define async_reset_active_high = !(rst0 && rst1),
  // then reset occurs when async_reset_active_high is 1.
  // The negedge of (rst0 && rst1) corresponds to the posedge of async_reset_active_high.
  wire async_reset_active_high;
  assign async_reset_active_high = !(rst0 && rst1);

  always_ff @(posedge clk or posedge async_reset_active_high) begin
    if (async_reset_active_high == 1'b1) begin // Explicit '==' operator used as per rule W442f
      q <= 1'b0;
    end else begin
      q <= d;
    Lend
  end

endmodule
