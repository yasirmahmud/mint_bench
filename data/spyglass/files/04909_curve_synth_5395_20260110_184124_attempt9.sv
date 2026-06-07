module curve_synth_5395_20260110_184124_attempt9 (
  input clk_a,
  input clk_b,
  output reg out_reg
);

  // SYNTH_5395: Improper asynchronous style of modeling. Not synthesizable.
  // This `always` block's sensitivity list includes two independent positive edge events:
  // `posedge clk_a` and `posedge clk_b`. Standard synthesizable flip-flops can only be
  // clocked by a single clock edge (or a single clock and a single asynchronous reset edge).
  // The presence of multiple, independent clock-like edge events in the sensitivity list
  // implies a multi-clock flip-flop, which is not supported by standard synthesis tools
  // and constitutes an improper asynchronous style of modeling.
  always @(posedge clk_a or posedge clk_b) begin
    out_reg <= ~out_reg;
  end

endmodule
