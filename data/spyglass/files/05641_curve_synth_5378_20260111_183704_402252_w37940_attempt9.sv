module curve_synth_5378_20260111_183704_402252_w37940_attempt9 (
    input wire clk_in,
    input wire enable_in, // This is a control signal, not intended as a separate clock.
    input wire data_in,
    output reg data_out
);

  // SYNTH_5378: Complex expression 'posedge (clk_in | reset_in)' is not allowed in event specification for synthesis.
  // This module triggers SYNTH_5378 by using a logical AND expression (clk_in & enable_in)
  // directly within the 'posedge' construct of the always block's sensitivity list.
  // The expression `(clk_in & enable_in)` is considered complex due to the logical operator.
  // By using an enable signal in an AND operation, we aim to avoid secondary violations
  // related to multiple clock domains or asynchronous resets that might occur with OR operations
  // involving primary resets or other clock sources.
  always @(posedge (clk_in & enable_in)) begin
    data_out <= data_in;
  end

endmodule
