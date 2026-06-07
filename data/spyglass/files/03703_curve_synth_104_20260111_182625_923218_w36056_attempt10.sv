module curve_synth_104_20260111_182625_923218_w36056_attempt10 (
  input wire a,
  input wire b,
  input wire clk
);

  reg reg_one;
  reg reg_two;
  reg reg_three;

  // SYNTH_104: DEASSIGN statements are not synthesizable
  always @* begin
    deassign reg_one;
  end

  // SYNTH_104: DEASSIGN statements are not synthesizable
  always @(a or b) begin
    deassign reg_two;
  end

  // SYNTH_104: DEASSIGN statements are not synthesizable
  always @(posedge clk) begin
    deassign reg_three;
  end

endmodule
