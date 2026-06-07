module curve_synth_5368_20260111_215330_271713_w15680_attempt11 (
  input wire data_in,
  input wire set_async,
  output reg q_out
);

  // SYNTH_5368: Clock signal 'q_out' read in asynchronous portion of clocked if-else construct - not synthesizable
  // This always block uses 'q_out' as a clock edge in its sensitivity list.
  // In the asynchronous 'if (set_async)' branch, 'q_out' is assigned, creating a feedback race.
  always @(negedge q_out or posedge set_async) begin
    if (set_async) begin // Asynchronous set condition
      q_out <= 1'b0;     // 'q_out' assigned asynchronously, while also being in sensitivity list
    end else begin
      q_out <= data_in;  // Synchronous data path relative to 'q_out's negedge
    end
  end

endmodule
