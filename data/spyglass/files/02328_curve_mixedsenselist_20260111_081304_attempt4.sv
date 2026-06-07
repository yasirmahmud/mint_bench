module curve_mixedsenselist_20260111_081304_attempt4 (
    input clk,
    input reset,        // Asynchronous active-high reset
    input data_in,
    input write_enable, // Level-sensitive enable for data write
    output reg data_out
);

  // This 'always' block is specifically designed to trigger the 'mixedsenselist' violation.
  // It contains both an edge-sensitive event (negedge clk) and a level-sensitive
  // event (write_enable) in its sensitivity list. This combination makes the block's
  // behavior ambiguous for synthesis tools, as it mixes sequential (clock edge) and
  // combinational (level-sensitive signal) triggering, which is generally unsynthesizable.
  always @(negedge clk or write_enable) begin
    if (reset) begin // Asynchronous active-high reset
      data_out <= 1'b0;
    end else if (write_enable) begin // Data update when write_enable is high
      data_out <= data_in;
    end
    // The logic inside, specifically the 'else if' without a final 'else', 
    // implies a latch when 'reset' is low and 'write_enable' is low. 
    // However, the 'mixedsenselist' violation typically takes precedence 
    // as a more fundamental issue regarding synthesizability of the block's trigger condition.
  end

endmodule
