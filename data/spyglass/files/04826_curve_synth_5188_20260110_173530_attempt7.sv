module curve_synth_5188_20260110_173530_attempt7 (
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

  // SYNTH_5188: Invalid placement of event control statement inside asynchronous implicit style always block.
  // This 'always' block is considered an asynchronous implicit style because it includes both
  // a clock edge (posedge clk) and an asynchronous reset edge (negedge rst_n) in its sensitivity list.
  // The assignment 'data_out <= @(posedge clk) data_in;' places an event control (@) directly
  // in the RHS of the assignment, which is not supported by synthesis in this context.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0;
    end else begin
      data_out <= @(posedge clk) data_in;
    end
  end

endmodule
