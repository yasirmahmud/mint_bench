module curve_synth_5368_20260110_183611_attempt9 (
  input wire data_in,
  input wire reset,
  output reg q_out
);

  // SYNTH_5368: Clock signal 'q_out' is read in the asynchronous portion of
  // the clocked if-else construct, making it not synthesizable.
  // 'q_out' serves as both a clock edge in the sensitivity list and is
  // asynchronously assigned during the 'reset' condition, creating a
  // problematic feedback race condition.
  always @(posedge q_out or posedge reset) begin
    if (reset) begin // Asynchronous reset condition
      q_out <= 1'b1; // q_out assigned asynchronously (distinct value from prior examples)
    end else begin
      q_out <= data_in; // Synchronous data path relative to q_out's edge
    end
  end

endmodule
