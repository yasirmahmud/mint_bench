module curve_synth_5059_20260110_122446_attempt2 (
  input  data_in,
  output reg out_neq
);

always @* begin
  // SYNTH_5058, W339a: Replaced !(===) with explicit if-else if to resolve synthesis violations while preserving X/Z behavior.
  if (data_in == 1'b0) begin
    out_neq = 1'b0;
  end else if (data_in == 1'b1) begin
    out_neq = 1'b1;
  }
  else begin // data_in is 1'bx or 1'bz
    out_neq = 1'b1;
  end
end

endmodule
