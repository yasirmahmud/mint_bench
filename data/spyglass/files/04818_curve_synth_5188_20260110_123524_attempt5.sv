module curve_synth_5188_20260110_123524_attempt5(
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);
  // Target rule: SYNTH_5188 -> Invalid placement of event control statement inside asynchronous implicit style always block.
  // This module directly implements the structure shown in the provided context example for SYNTH_5188.
  // Previous attempt (Attempt 4), which was semantically identical but formatted differently, triggered SYNTH_5317 
  // ("Always block that has both a timing control statement as well as embedded event (@) expression is not supported by synthesis")
  // instead of SYNTH_5188. This attempt aims to exactly match the syntax and structure of the provided context example
  // to prevent SYNTH_5317 and specifically trigger SYNTH_5188, assuming the context example correctly triggers only SYNTH_5188.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) data_out <= 1'b0;
    else data_out <= @(posedge clk) data_in;
  end

endmodule
