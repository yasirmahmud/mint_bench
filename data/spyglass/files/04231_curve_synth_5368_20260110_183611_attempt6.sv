module curve_synth_5368_20260110_183611_attempt6 (
  input data_in,
  input reset,
  output reg q_out
);

  // SYNTH_5368: q_out is used as a clock in its own sensitivity list,
  // creating a flop feedback race condition.
  always @(posedge q_out or posedge reset) begin
    if (reset) begin
      q_out <= 1'b0;
    end else begin
      q_out <= data_in;
    end
  end

endmodule
