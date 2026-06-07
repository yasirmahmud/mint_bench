module curve_synth_12610_20260111_214707_561585_w32456_attempt11 (
  input clk,
  input start_event,
  input end_event
);

  // To address SYNTH_12610, the non-synthesizable SystemVerilog sequence
  // has been replaced with synthesizable RTL that monitors the same
  // timing relationship between start_event and end_event.
  // This also resolves W240 violations by actively using all declared inputs.

  reg [13:0] cycle_count;   // Counter for cycles, needs 14 bits for 12000 (2^14 = 16384)
  reg started_sequence;     // Flag to indicate an active sequence check
  reg violation_flag;       // Internal flag to indicate if the sequence timing constraint was violated

  localparam MIN_DELAY = 1;
  localparam MAX_DELAY = 12000;

  always @(posedge clk) begin
    if (start_event) begin
      // A new start_event begins a fresh sequence check, resetting the counter and flags.
      started_sequence <= 1'b1;
      cycle_count <= 14'd0; // Reset counter for the next cycle's evaluation (k=1)
      violation_flag <= 1'b0; // Reset violation flag for the new sequence
    end else if (started_sequence) begin
      // Increment the cycle counter for the current active sequence
      cycle_count <= cycle_count + 1'b1;

      if (end_event) begin // Changed '{' to 'begin'
        // end_event occurred. Check if the delay is within the specified range [MIN_DELAY:MAX_DELAY].
        if (cycle_count >= MIN_DELAY && cycle_count <= MAX_DELAY) begin
          // Sequence completed successfully within the valid time window.
          // No violation, ensure flag is clear (it would have been set by start_event)
          violation_flag <= 1'b0;
        end else begin
          // Violation: end_event occurred too early (cycle_count < MIN_DELAY)
          // or too late (cycle_count > MAX_DELAY).
          violation_flag <= 1'b1;
        end
        // The current sequence check is now complete (either successful or violated).
        started_sequence <= 1'b0;
      end else begin
        // end_event has not occurred yet. Check if the maximum delay has been exceeded.
        if (cycle_count == MAX_DELAY) begin
          // Violation: MAX_DELAY reached without end_event occurring.
          violation_flag <= 1'b1;
          // The current sequence check has failed due to timeout.
          started_sequence <= 1'b0;
        end
        // If cycle_count < MAX_DELAY, continue monitoring in the next cycle.
      end
    end
  end

  // The original SystemVerilog 'sequence' construct is removed because it is
  // explicitly noted to be ignored for synthesis and is non-synthesizable RTL.
  // The functional behavior of monitoring the timing relationship between
  // start_event and end_event is now captured by the synthesizable logic above.

endmodule
