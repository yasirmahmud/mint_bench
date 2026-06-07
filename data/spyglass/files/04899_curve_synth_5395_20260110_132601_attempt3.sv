module curve_synth_5395_20260110_132601_attempt3 (
  input clk,
  input rst_n, // Active-low asynchronous reset
  input data_event_trigger, // An independent input signal
  output reg out_reg
);

  // This 'always' block's sensitivity list includes:
  // 1. A clock edge (posedge clk)
  // 2. An asynchronous reset edge (negedge rst_n)
  // 3. A *third* edge-sensitive data signal (posedge data_event_trigger)
  //
  // The presence of a third distinct edge-sensitive event (data_event_trigger)
  // that is neither the primary clock nor a dedicated reset is considered
  // an "improper asynchronous style of modeling" and is not synthesizable.
  // This pattern is expected to trigger SYNTH_5395 ("repeat_event_example").
  // By using an input 'data_event_trigger' instead of an internally derived signal,
  // this attempts to differentiate from rules like STARC05-2.3.3.1 and W422
  // which might categorize internally derived signals as 'multiple clocks'.
  always @(posedge clk or negedge rst_n or posedge data_event_trigger) begin
    if (!rst_n) begin
      // Asynchronous reset condition
      out_reg <= 1'b0;
    end else begin
      // This logic will be triggered by either posedge clk or posedge data_event_trigger.
      // The violation lies primarily in the sensitivity list having more than two primary events.
      out_reg <= ~out_reg; // Simple toggling behavior
    end
  end

endmodule
