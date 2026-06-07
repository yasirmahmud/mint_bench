module curve_synth_5368_20260112_001543_094701_w25608_attempt16 (
  input wire data_in,
  input wire reset_n,
  output reg q_out
);

  // SYNTH_5368: Clock signal 'q_out' read in asynchronous portion of clocked if-else construct - not synthesizable
  // This 'always' block creates a feedback race condition.
  // 'q_out' is used as a clock signal (negedge q_out) in the sensitivity list.
  // Concurrently, 'q_out' is assigned a value asynchronously (q_out <= 1'b1) within the 'if (!reset_n)' block.
  always @(negedge q_out or negedge reset_n) begin
    if (!reset_n) begin // Active-low asynchronous reset condition
      q_out <= 1'b1;     // 'q_out' is assigned asynchronously, creating the feedback race.
    end else begin
      q_out <= data_in;  // Synchronous data path relative to 'q_out's negedge.
    end
  end

endmodule
