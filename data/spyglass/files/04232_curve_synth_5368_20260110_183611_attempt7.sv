module curve_synth_5368_20260110_183611_attempt7 (
  input data_in,
  input set_async,
  output reg q_out
);

  // SYNTH_5368: Clock signal 'q_out' is used in its own sensitivity list as a clock,
  // and is also assigned in the asynchronous portion of the clocked if-else construct.
  // This creates a flop feedback race and is not synthesizable.
  always @(negedge q_out or negedge set_async) begin
    if (~set_async) begin // Asynchronous set condition
      q_out <= 1'b1;
    end else begin
      q_out <= data_in;
    end
  end

endmodule
