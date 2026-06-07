module curve_synth_104_20260110_230147_attempt5 (
  input clk,
  output reg my_reg1,
  output reg my_reg2,
  output reg my_reg3
);

  // SYNTH_104: DEASSIGN statements are not synthesizable.
  always @(negedge clk) begin
    deassign my_reg1;
    deassign my_reg2;
    deassign my_reg3;
  end

endmodule
