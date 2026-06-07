module curve_synth_78_20260111_070734_attempt2 (
  input wire clk_i,
  input wire rst_ni,
  input wire start_i,
  output reg done_o
);

  // Flag to track if start_i has been high and we are now waiting for it to go low.
  reg waiting_for_start_low;

  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      done_o <= 1'b0;
      waiting_for_start_low <= 1'b0; // Reset the state flag
    end else begin
      // Default done_o to low for the current cycle
      done_o <= 1'b0;

      if (start_i == 1'b1) begin
        // If start_i is currently high, we are in a state where we 'wait' for it to go low.
        // Set the flag to indicate we are waiting.
        waiting_for_start_low <= 1'b1;
      end else begin // start_i == 1'b0
        // If start_i is currently low
        if (waiting_for_start_low == 1'b1) begin
          // If we were previously waiting for start_i to go low (meaning it was high),
          // and now it has gone low, then this is the trigger condition.
          done_o <= 1'b1; // Set done_o high for this cycle
          waiting_for_start_low <= 1'b0; // Reset the flag as the 'wait' condition is met and done_o is pulsed
        end else begin
          // start_i is low, and we were not waiting (either it was always low,
          // or the sequence completed in a previous cycle).
          waiting_for_start_low <= 1'b0; // Ensure the flag is low
          // done_o is already 1'b0 from the default assignment
        end
      end
    end
  end

endmodule
