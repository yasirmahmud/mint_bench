module curve_synth_5395_20260112_001708_829702_w6680_attempt20 (
    input wire clk,
    input wire rst_n,
    input wire enable_sync_increment,
    output reg [7:0] data_out
);

  // Internal signal to create a non-standard asynchronous trigger
  reg internal_async_trigger_r;
  reg internal_async_trigger_d;

  // Synchronous logic to generate a rising edge on internal_async_trigger_r
  // when enable_sync_increment becomes active. This is not the primary clock
  // or an official reset, but its edge will be used in another always block.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      internal_async_trigger_r <= 1'b0;
      internal_async_trigger_d <= 1'b0;
    end else begin
      internal_async_trigger_r <= enable_sync_increment;
      internal_async_trigger_d <= internal_async_trigger_r;
    end
  end

  // SYNTH_5395 violation: Improper asynchronous style of modeling. Not synthesizable.
  // This 'always' block is sensitive to: 
  // 1. 'posedge clk' (primary clock)
  // 2. 'negedge rst_n' (standard asynchronous reset)
  // 3. 'posedge internal_async_trigger_r' (an additional edge-triggered signal).
  // 'internal_async_trigger_r' is an internal signal whose rising edge is being used
  // as an asynchronous event alongside the clock and reset. Furthermore, inside the block,
  // the signal's *level* (`if (internal_async_trigger_r)`) is checked, attempting to create
  // an asynchronous set-like behavior. This combination of an edge-triggered sensitivity
  // for a non-reset signal and a level-sensitive check for the same signal in the same block
  // results in an improper and non-synthesizable asynchronous modeling style, as flip-flops
  // typically support one clock and one async reset/set, not arbitrary async edge-triggered
  // data operations combined with level checks.
  always @(posedge clk or negedge rst_n or posedge internal_async_trigger_r) begin
    if (!rst_n) begin
      data_out <= 8'b0; // Asynchronous reset
    end else if (internal_async_trigger_r) begin // Problematic: level check for an edge-sensitive signal
      data_out <= 8'hFF; // Asynchronous set-like behavior triggered by internal_async_trigger_r
    end else begin
      // Synchronous increment on clock edge if no async set is active
      data_out <= data_out + 8'b1; 
    end
  end

endmodule
