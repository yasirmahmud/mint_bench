module curve_synth_5188_20260110_123524_attempt3(
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

  // This is an 'always @(*)' block, which is considered an asynchronous implicit style block (combinational).
  // The event control statement on the RHS of the assignment below is invalid for synthesis and triggers SYNTH_5188.
  always @(*) begin
    if (!rst_n) begin
      data_out = 1'b0; // Blocking assignment for combinational logic
    end else begin
      // SYNTH_5188: Invalid placement of event control statement in an asynchronous implicit style always block
      data_out = @(posedge clk) data_in; // Violation here
    end
  end

endmodule
