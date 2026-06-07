module curve_mixedsenselist_20260111_081304_attempt4 (
    input clk,
    input reset,        // Asynchronous active-high reset
    input data_in,
    input write_enable, // Level-sensitive enable for data write
    output reg data_out
);

  // Original intent to trigger 'mixedsenselist' violation has been resolved.
  // The block is now correctly described as a transparent latch with asynchronous reset,
  // aligning with the natural language description of a "level-sensitive enable".
  // The 'clk' input is not used as the data write is level-sensitive, not clock-edge sensitive.
  always @(reset or write_enable or data_in) begin
    if (reset) begin // Asynchronous active-high reset
      data_out <= 1'b0;
    end else if (write_enable) begin // Data update when write_enable is high
      data_out <= data_in;
    end
    // When reset is low and write_enable is low, data_out retains its value,
    // implicitly describing a transparent latch. No clock edge is involved in its functional update.
  end

endmodule
