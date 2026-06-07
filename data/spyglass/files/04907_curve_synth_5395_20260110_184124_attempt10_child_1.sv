module curve_synth_5395_20260110_184124_attempt10 (
  input clk,
  input rst_n,
  input trigger_signal,
  input data_in,
  output reg out_reg
);

  // SYNTH_5395: Improper asynchronous style of modeling. Not synthesizable.
  // Original Issue: The sensitivity list included posedge clk, negedge rst_n, AND posedge trigger_signal.
  // This constitutes "multiple clocks used in the same always block" (violations STARC05-2.3.3.1 and W422).
  // Violation badimplicitSM1 refers to asynchronous reset priority, which is already correctly handled
  // by checking !rst_n first. However, having trigger_signal as an independent edge event is the core problem.
  
  // Fix: To resolve the multiple clock violations while preserving the primary clocking behavior
  // and the data loading, 'clk' is designated as the sole clock for the sequential block.
  // The original design description states: "The logic here is triggered by posedge clk OR posedge trigger_signal (after reset)."
  // And the action is: "out_reg <= data_in;" unconditionally after reset.
  // In a synthesizable context, an unconditional data load on 'posedge clk' will inherently capture 'data_in'
  // whenever 'clk' rises. If 'trigger_signal' is also meant to cause an update to the *same* 'data_in'
  // independently, that is an unsynthesizable multiple-clock scenario for a single flip-flop.
  // The most standard and synthesizable interpretation that fixes the lint errors, given the unconditional
  // data load, is to simplify 'out_reg' to a standard D-flip-flop clocked by 'clk'.
  // The effect of 'posedge trigger_signal' as an *independent* trigger cannot be preserved with standard
  // synthesizable logic for a single register when 'out_reg <= data_in;' is unconditional on 'posedge clk'.
  // Therefore, 'clk' becomes the sole clock, and 'trigger_signal' no longer acts as an independent clock event.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Asynchronous active-low reset
      out_reg <= 1'b0;
    end else begin
      // After reset, out_reg samples data_in on every positive edge of clk.
      // This preserves the 'posedge clk' trigger and the unconditional 'out_reg <= data_in' behavior
      // from the original design, within a single clock domain.
      out_reg <= data_in;
    end
  end

endmodule
