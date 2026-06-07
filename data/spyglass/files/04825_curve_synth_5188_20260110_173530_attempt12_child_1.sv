module curve_synth_5188_20260110_173530_attempt12 (
  input clk,
  input async_enable,
  input data_in,
  output reg data_out
);

  // Target rule: SYNTH_5188
  // Rule description: Invalid placement of event control statement inside asynchronous implicit style always block. Not supported.
  // The original design attempted to use an event control statement on the RHS of a non-blocking assignment
  // within an 'always' block with an asynchronous sensitivity list, which is unsynthesizable.
  // The problematic line was: 'data_out <= @(posedge clk) data_in;' inside an 'if (async_enable)' block.
  // In simulation, this construct would cause 'data_out' to be updated with 'data_in' at the *next* 'posedge clk',
  // effectively re-synchronizing the assignment even if the 'always' block was triggered asynchronously by 'async_enable'.
  // The 'else' path also updated 'data_out <= data_in;' synchronously with 'posedge clk'.
  // Therefore, the functional behavior of 'data_out' was always to follow 'data_in' on 'posedge clk',
  // irrespective of the state or transitions of 'async_enable'.
  // The 'async_enable' input is preserved in the port list but is not used in the corrected logic, as its effective
  // functional impact on 'data_out' was nullified by the problematic event control statement's re-synchronization.

  always @(posedge clk) begin
    data_out <= data_in;
  end

endmodule
