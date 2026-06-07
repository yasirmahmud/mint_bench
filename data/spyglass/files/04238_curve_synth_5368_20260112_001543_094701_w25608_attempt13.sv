module curve_synth_5368_20260112_001543_094701_w25608_attempt13 (
  input wire data_in,
  input wire async_set,
  output reg q_out
);

  // SYNTH_5368: Clock signal 'q_out' read in asynchronous portion of clocked if-else construct - not synthesizable
  // This 'always' block defines a feedback race condition.
  // 'q_out' is used as a clock signal in the sensitivity list (posedge q_out).
  // Concurrently, 'q_out' is also assigned a value asynchronously in the 'if (async_set)' block.
  // This simultaneous use as a clock and asynchronous assignment by itself creates the violation.
  always @(posedge q_out or posedge async_set) begin
    if (async_set) begin // Asynchronous set condition
      q_out <= 1'b1;     // 'q_out' is assigned asynchronously, creating the feedback race.
    end else begin
      q_out <= data_in;  // Synchronous data path relative to 'q_out's posedge.
    end
  end

endmodule
