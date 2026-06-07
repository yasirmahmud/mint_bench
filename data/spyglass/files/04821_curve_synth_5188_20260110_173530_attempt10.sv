module curve_synth_5188_20260110_173530_attempt10 (
  input clock,
  input reset_n,
  input [1:0] input_val,
  output reg [1:0] output_reg
);

  // SYNTH_5188: Invalid placement of event control statement inside asynchronous implicit style always block. Not supported.
  // This always block is an "asynchronous implicit style" block due to the inclusion of both
  // a clock edge (posedge clock) and an asynchronous reset edge (negedge reset_n) in its sensitivity list.
  // The assignment 'output_reg <= @(posedge clock) input_val;' places an event control (@)
  // directly in the RHS of the non-blocking assignment, which is specifically targeted by SYNTH_5188
  // in this asynchronous context as an unsupported construct.
  always @(posedge clock or negedge reset_n) begin
    if (!reset_n) begin
      output_reg <= 2'b0;
    end else begin
      output_reg <= @(posedge clock) input_val; // Target violation: Event control on RHS
    end
  end

endmodule
