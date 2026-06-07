module curve_synth_5188_20260110_173530_attempt14 (
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

  // Target rule: SYNTH_5188
  // Invalid placement of event control statement inside asynchronous implicit style always block.
  always @(posedge clk or negedge rst_n)
    if (!rst_n)
      data_out <= 1'b0;
    else
      // This line triggers SYNTH_5188: event control on RHS of assignment
      // within an asynchronous always block.
      data_out <= @(posedge clk) data_in;

endmodule
