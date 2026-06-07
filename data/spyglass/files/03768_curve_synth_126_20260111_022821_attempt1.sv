module curve_synth_126_20260111_022821_attempt1 (
  input clk,
  input d,
  output reg q
);

  always @(posedge clk) begin
    // SYNTH_126: Procedural continuous assign statement is not synthesizable
    assign q = d;
  end

endmodule
