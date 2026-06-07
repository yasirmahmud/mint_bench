module curve_synth_5263_20260110_155455_attempt1 (
  input clk,
  output reg out1,
  output reg out2
);

  always @(posedge clk) begin
    fork
      out1 <= 1'b0;
    join

    fork
      out2 <= 1'b1;
    join
  end

endmodule
