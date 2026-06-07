module curve_synth_5368_20260110_132041_attempt4 (
    input data_in,
    input reset,
    output reg q_out
);

  always @(posedge q_out or posedge reset) begin
    if (reset) begin
      q_out <= 1'b0;
    end else begin
      q_out <= data_in;
    end
  end

endmodule
