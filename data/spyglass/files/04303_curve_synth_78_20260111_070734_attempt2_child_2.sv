module curve_synth_78_20260111_070734_attempt2 (
  input wire clk_i,
  input wire rst_ni,
  input wire start_i,
  output reg done_o
);

  // Flag to track if start_i has been high and we are now waiting for it to go low.
  reg waiting_for_start_low;

  // Wires for next-state and next-output logic, to separate combinational and sequential parts.
  wire waiting_for_start_low_next;
  wire done_o_next;

  // Sequential part: register updates
  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      done_o <= 1'b0;
      waiting_for_start_low <= 1'b0;
    end else begin
      // Update registers with their next values determined by the combinational logic
      done_o <= done_o_next;
      waiting_for_start_low <= waiting_for_start_low_next;
    end
  end

  // Combinational part: next-state and output logic
  always @(*) begin
    // Default assignments to avoid latch inference and for cases not explicitly covered.
    // The state and output are assumed to remain unchanged unless explicitly set.
    waiting_for_start_low_next = waiting_for_start_low; // Default to stay in current state
    done_o_next = 1'b0; // Default done_o_next to low

    if (start_i == 1'b1) begin
      // If start_i is currently high, the FSM transitions to the 'waiting for low' state.
      waiting_for_start_low_next = 1'b1;
      // done_o_next remains 0 as per default
    end else begin // start_i == 1'b0
      // If start_i is currently low
      if (waiting_for_start_low == 1'b1) begin
        // If we were previously in the 'waiting for low' state (meaning start_i was high in the previous cycle),
        // and now start_i has gone low, this is the trigger condition.
        done_o_next = 1'b1; // Set done_o_next high for this cycle (pulse output)
        waiting_for_start_low_next = 1'b0; // Transition FSM back to 'idle' state
      end else begin
        // If start_i is low, and we were not in the 'waiting for low' state (i.e., we were idle),
        // then we remain in the 'idle' state.
        waiting_for_start_low_next = 1'b0; // Ensure the flag is low (stay idle)
        // done_o_next remains 0 as per default
      end
    end
  end

endmodule
