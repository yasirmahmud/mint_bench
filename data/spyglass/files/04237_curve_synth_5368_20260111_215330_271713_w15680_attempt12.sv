module curve_synth_5368_20260111_215330_271713_w15680_attempt12 (
  input wire data_in,
  input wire reset_n,
  output reg q_out
);

  // SYNTH_5368: Clock signal 'q_out' read in asynchronous portion of clocked if-else construct - not synthesizable
  // This 'always' block is sensitive to the positive edge of 'q_out' (acting as a clock).
  // It also has an asynchronous reset condition triggered by 'negedge reset_n'.
  // Inside the asynchronous reset branch ('if (!reset_n)'), 'q_out' itself is assigned ('q_out <= 1'b1;').
  // This creates a feedback race condition where 'q_out' is both the clock and an asynchronously set signal within the same clocked construct.
  always @(posedge q_out or negedge reset_n) begin
    if (!reset_n) begin // Active-low asynchronous reset condition
      q_out <= 1'b1;     // 'q_out' is assigned asynchronously, creating the feedback race.
    end else begin
      q_out <= data_in;  // Synchronous data path relative to 'q_out's posedge.
    end
  end

endmodule
