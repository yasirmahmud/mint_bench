module curve_synth_5288_20260110_125813_attempt1 (
  input clk,
  input rst_n,
  input trigger_in,
  output reg output_q
);

  // Declare an event type variable
  event my_event;

  // Synthesizable block: Triggers the event based on 'trigger_in'
  // This block also provides a synthesizable driver for 'output_q' with reset.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      output_q <= 1'b0; // Initialize output_q to 0 on reset
    end else begin
      if (trigger_in) begin
        -> my_event; // Trigger the event
      end
      // If the 'always @(my_event)' block is ignored for synthesis due to SYNTH_5288,
      // then output_q maintains its value (effectively a D-flop driven by this block).
    end
  end

  // Unsynthesizable block: Sensitive to the 'event' variable in its sensitivity list.
  // This is the direct cause of the SYNTH_5288 violation.
  // Although it attempts to drive 'output_q' (which would be a multiple driver issue
  // if both always blocks were synthesizable), SpyGlass is expected to flag SYNTH_5288
  // as an ERROR and then ignore this block for further synthesis checks, thus
  // avoiding other violations like multiple drivers or latches.
  always @(my_event) begin // This line is expected to trigger SYNTH_5288
    output_q = ~output_q; // Toggle 'output_q' when the event occurs (blocking assignment for simulation)
  end

endmodule
