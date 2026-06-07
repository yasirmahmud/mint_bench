module curve_synth_104_20260111_182625_923218_w36056_attempt9 (
  input clk,
  input rst
);

  reg my_reg_a;
  reg my_reg_b;
  reg my_reg_c;

  // SYNTH_104: DEASSIGN statements are not synthesizable
  always @(posedge clk) begin
    deassign my_reg_a;
  end

  // SYNTH_104: DEASSIGN statements are not synthesizable
  always @(negedge clk) begin
    deassign my_reg_b;
  end

  // SYNTH_104: DEASSIGN statements are not synthesizable
  always @(posedge rst) begin
    deassign my_reg_c;
  end

endmodule
