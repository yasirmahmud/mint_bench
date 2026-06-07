module curve_synth_78_20260111_070734_attempt5 (
  input wire clk,
  input wire rst_n,
  input wire trigger_in,
  output reg data_out
);

  // Register to track if trigger_in has ever been asserted after reset.
  // This resolves SYNTH_78 by replacing the non-synthesizable 'wait' construct.
  // The original behavior, where 'wait' pauses execution and then an assignment occurs,
  // implies data_out goes high and stays high once trigger_in is asserted post-reset.
  reg triggered_flag;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0;
      triggered_flag <= 1'b0; // Reset the flag along with data_out
    end else begin
      // If trigger_in is asserted, set the flag. Once set, the flag remains set until reset.
      if (trigger_in == 1'b1) begin
        triggered_flag <= 1'b1;
      end

      // data_out should become 1 if the trigger_in has ever been asserted (post-reset).
      // This mimics the 'wait' construct: once the condition is met, the subsequent
      // assignment executes. If the condition is not met on subsequent cycles, the assignment
      // is effectively skipped, causing data_out to latch its last assigned value (1'b1).
      if (triggered_flag) begin
        data_out <= 1'b1;
      end else {
        // If not yet triggered, data_out should remain 0 (its reset value).
        data_out <= 1'b0;
      }
    end
  end

endmodule
