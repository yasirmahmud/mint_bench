module curve_synth_104_20260111_182625_923218_w36056_attempt7 (
);

  reg my_reg_to_deassign;

  initial begin
    // SYNTH_104: DEASSIGN statements are not synthesizable
    deassign my_reg_to_deassign;
  end

endmodule
