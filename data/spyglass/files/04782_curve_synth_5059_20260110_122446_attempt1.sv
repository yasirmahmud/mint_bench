module curve_synth_5059_20260110_122446_attempt1 (
  input [7:0] data_a,
  input [7:0] data_b,
  output reg  out_neq
);

always @* begin
  // SYNTH_5059: Case inequality (!==) is not supported by synthesis
  if (data_a !== data_b) begin
    out_neq = 1'b1;
  end else begin
    out_neq = 1'b0;
  end
end

endmodule
