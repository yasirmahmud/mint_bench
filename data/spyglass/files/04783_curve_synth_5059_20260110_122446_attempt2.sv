module curve_synth_5059_20260110_122446_attempt2 (
  input  data_in,
  output reg out_neq
);

always @* begin
  // SYNTH_5059: Case inequality (!==) is not supported by synthesis
  out_neq = (data_in !== 1'b0);
end

endmodule
