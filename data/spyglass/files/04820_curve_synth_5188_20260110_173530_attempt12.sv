module curve_synth_5188_20260110_173530_attempt12 (
  input clk,
  input async_enable,
  input data_in,
  output reg data_out
);

  // Target rule: SYNTH_5188
  // Rule description: Invalid placement of event control statement inside asynchronous implicit style always block. Not supported.
  // This module is designed to trigger SYNTH_5188 by placing an event control statement
  // on the RHS of a non-blocking assignment within an 'always' block that has an
  // asynchronous sensitivity list.
  always @(posedge clk or posedge async_enable) begin
    if (async_enable) begin
      // This branch is activated asynchronously by 'async_enable'.
      // Placing an event control statement (@(posedge clk)) here creates the SYNTH_5188 violation.
      data_out <= @(posedge clk) data_in;
    end else begin
      // This is a standard synchronous update path if 'async_enable' is not active.
      data_out <= data_in;
    end
  end

endmodule
