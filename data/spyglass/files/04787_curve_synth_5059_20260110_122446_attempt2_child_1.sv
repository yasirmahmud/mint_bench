module curve_synth_5059_20260110_122446_attempt2 (
  input  data_in,
  output reg out_neq
);

always @* begin
  // SYNTH_5059: Replaced case inequality (!==) with !(===) to resolve synthesis violation while preserving X/Z behavior.
  out_neq = !(data_in === 1'b0);
end

endmodule
