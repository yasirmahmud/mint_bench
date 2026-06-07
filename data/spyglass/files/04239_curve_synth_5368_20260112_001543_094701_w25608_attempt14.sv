module curve_synth_5368_20260112_001543_094701_w25608_attempt14 (
  input wire data_in,
  input wire async_reset,
  output reg q_out
);

  // SYNTH_5368: Clock signal 'q_out' read in asynchronous portion of clocked if-else construct - not synthesizable
  // This 'always' block creates a feedback race condition.
  // 'q_out' is used as a clock signal (negedge q_out) in the sensitivity list.
  // Concurrently, 'q_out' is assigned a value asynchronously (q_out <= 1'b1) within the 'if (!async_reset)' block.
  // This simultaneous use as a clock and asynchronous assignment by itself creates the violation.
  always @(negedge q_out or negedge async_reset) begin
    if (!async_reset) begin // Asynchronous active-low reset condition
      q_out <= 1'b1;     // 'q_out' is assigned asynchronously, creating the feedback race.
    end else begin
      q_out <= data_in;  // Synchronous data path relative to 'q_out's negedge.
    end
  end

endmodule
