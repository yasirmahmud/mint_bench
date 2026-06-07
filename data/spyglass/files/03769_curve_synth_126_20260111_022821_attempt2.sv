module curve_synth_126_20260111_022821_attempt2 (
  input  in_a,
  input  in_b,
  output reg out_c
);

  // SYNTH_126: Procedural continuous assign statement is not synthesizable
  always @(in_a or in_b) begin
    assign out_c = in_a && in_b;
  end

endmodule
