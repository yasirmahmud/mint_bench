module curve_synth_104_20260111_182625_923218_w36056_attempt8 (
  input clk
);

  reg my_reg_1;
  reg my_reg_2;
  reg my_reg_3;

  // SYNTH_104: DEASSIGN statements are not synthesizable
  always @(posedge clk) begin
    deassign my_reg_1;
    deassign my_reg_2;
    deassign my_reg_3;
  end

endmodule
