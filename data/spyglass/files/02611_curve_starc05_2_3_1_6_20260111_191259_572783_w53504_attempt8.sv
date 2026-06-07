module curve_starc05_2_3_1_6_20260111_191259_572783_w53504_attempt8 (
  input wire clk,
  input wire rst_async,   // Primary asynchronous reset (active low, correctly handled)
  input wire rst_check,   // Signal for STARC05-2.3.1.6 violation
  input wire data_in,
  output reg data_out
);

  // This always block implements a D-type flip-flop with an asynchronous reset.
  // It includes `negedge rst_async` as the main asynchronous reset, which is correctly handled.
  // Additionally, `posedge rst_check` is included in the sensitivity list.
  // The violation occurs because `rst_check` is later checked with active-low logic (`~rst_check`)
  // in an `else if` condition, which contradicts the `posedge rst_check` in the sensitivity list
  // implying an active-high edge.
  always @(posedge clk or negedge rst_async or posedge rst_check) begin
    if (!rst_async) begin // Correct active-low asynchronous reset for synthesis
      data_out <= 1'b0;
    end else if (~rst_check) begin // STARC05-2.3.1.6 violation: logic level check (~rst_check) mismatches edge (posedge rst_check)
      // The sensitivity list implies `rst_check` is active-high for an asynchronous event.
      // However, the condition checks for `~rst_check` (active-low).
      // This triggers the STARC05-2.3.1.6 rule as a warning.
      // By placing this in an `else if` after a correctly implemented asynchronous reset,
      // we aim to prevent other synthesis errors (like SYNTH_5192) that might occur
      // if the primary asynchronous reset itself had this mismatch.
      data_out <= data_in;
    end else begin
      data_out <= 1'b1; // Default operation when no reset/special condition is active
    end
  end

endmodule
