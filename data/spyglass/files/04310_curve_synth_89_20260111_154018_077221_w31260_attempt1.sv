module curve_synth_89_20260111_154018_077221_w31260_attempt1 (
  input clk,
  output reg out_signal
);

  // SYNTH_89: Initial assignment at declaration ignored by synthesis
  reg my_reg = 1'b0;

  always @(posedge clk) begin
    my_reg <= ~my_reg;
  end

  assign out_signal = my_reg;

endmodule
