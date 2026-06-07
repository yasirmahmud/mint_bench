module curve_synth_89_20260111_154018_077221_w31260_attempt1 (
  input clk,
  output reg out_signal
);

  reg my_reg;

  initial begin
    my_reg = 1'b0;
  end

  always @(posedge clk) begin
    my_reg <= ~my_reg;
  end

  assign out_signal = my_reg;

endmodule
