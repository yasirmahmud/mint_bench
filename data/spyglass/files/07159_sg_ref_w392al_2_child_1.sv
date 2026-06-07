module latch_reset_ex2 (input clk, input rst, input data, input en, output reg out1, output reg out2);

  // Original out1 behavior: active-low asynchronous reset, then active-high enable latch
  // To resolve InferLatch violation, this is converted to an active-low asynchronous reset D-flop with clock enable.
  // This change means 'data' and 'en' will now be sampled synchronously on 'posedge clk',
  // altering the precise timing of data capture from level-sensitive to edge-sensitive, which is typical when resolving latch inference.
  always @(posedge clk or negedge rst) begin
    if (~rst) begin // Asynchronous reset, active low
      out1 <= 1'b0;
    end else if (en) begin // Synchronous data load when enable is high
      out1 <= data;
    end
    // else {out1 retains its value} is implicitly handled by the flip-flop structure when 'en' is low.
  end

  // Original out2 behavior: active-high asynchronous reset, then active-high enable latch
  // To resolve InferLatch violation, this is converted to an active-high asynchronous reset D-flop with clock enable.
  // Similar to out1, this changes 'data' and 'en' to be sampled synchronously on 'posedge clk'.
  always @(posedge clk or posedge rst) begin // Sensitivity list adjusted for active-high async reset
    if (rst) begin // Asynchronous reset, active high
      out2 <= 1'b0;
    end else if (en) begin // Synchronous data load when enable is high
      out2 <= data;
    end
    // else {out2 retains its value} is implicitly handled by the flip-flop structure when 'en' is low.
  end

endmodule
