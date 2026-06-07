module curve_synth_5368_20260110_183611_attempt8 (
  input data_in,
  input reset_n,
  output reg q_out
);

  // SYNTH_5368: Clock signal 'q_out' is used in the sensitivity list
  // and is also assigned in the asynchronous portion of the always block
  // (triggered by `reset_n`), leading to a flop feedback race.
  always @(posedge q_out or negedge reset_n) begin
    if (!reset_n) begin // Asynchronous reset condition
      q_out <= 1'b0;    // q_out assigned asynchronously
    end else begin
      q_out <= data_in; // Synchronous data path relative to q_out's edge
    end
  end

endmodule
