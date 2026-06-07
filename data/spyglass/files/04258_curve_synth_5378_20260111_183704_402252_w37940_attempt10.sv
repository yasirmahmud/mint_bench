module curve_synth_5378_20260111_183704_402252_w37940_attempt10 (
    input wire clk_in,
    input wire data_in,
    output reg data_out
);

  // SYNTH_5378: Complex expression 'posedge (clk_in | reset_in)' is not allowed in event specification for synthesis.
  // This module triggers SYNTH_5378 by using a complex expression '(~clk_in)'
  // directly within the 'posedge' construct of the always block's sensitivity list.
  // The expression `(~clk_in)` is considered complex due to the logical NOT operator.
  // This approach aims to isolate the SYNTH_5378 violation by using an operation
  // on a single input signal, thereby avoiding interpretations as multiple clock domains
  // or clock gating which led to additional violations (e.g., STARC05-2.3.3.1, W422) in previous attempts.
  // While functionally equivalent to `negedge clk_in`, the specific syntax `posedge (~clk_in)`
  // constitutes a 'complex expression' for this rule.
  always @(posedge (~clk_in)) begin
    data_out <= data_in;
  end

endmodule
