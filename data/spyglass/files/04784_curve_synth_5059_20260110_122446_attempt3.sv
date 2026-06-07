module curve_synth_5059_20260110_122446_attempt3 (
  input  [3:0] data_in,
  input  [3:0] compare_val,
  output reg   out_neq
);

always @* begin
  // SYNTH_5059: Case inequality (!==) is not supported by synthesis
  if (data_in !== compare_val) begin
    out_neq = 1'b1;
  end else begin
    out_neq = 1'b0;
  end
end

endmodule
