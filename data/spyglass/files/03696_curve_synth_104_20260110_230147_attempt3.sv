module curve_synth_104_20260110_230147_attempt3 (
  input clk
);

  reg my_reg;

  // SYNTH_104: DEASSIGN statements are not synthesizable.
  always @(negedge clk) begin
    deassign my_reg;
  end

endmodule
