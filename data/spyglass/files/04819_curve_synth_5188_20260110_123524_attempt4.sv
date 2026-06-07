module curve_synth_5188_20260110_123524_attempt4(
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

  // This always block is sensitive to both clock and reset edges.
  // The SYNTH_5188 violation occurs due to the placement of an event control
  // statement (@(posedge clk)) on the RHS of an assignment within this block.
  // This construct is explicitly identified as unsynthesizable for the target rule.
  // Based on the provided context example, this specific structure triggers SYNTH_5188
  // without also triggering SYNTH_5317.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0; // Asynchronous reset for data_out
    end else begin
      // SYNTH_5188: Invalid placement of event control statement inside an always block.
      // This line is expected to trigger the violation.
      data_out <= @(posedge clk) data_in; // Event control on RHS
    end
  end

endmodule
