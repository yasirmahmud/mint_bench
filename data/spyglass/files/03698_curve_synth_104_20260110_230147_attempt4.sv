module curve_synth_104_20260110_230147_attempt4 (
  input event_signal
);

  reg my_reg;

  // SYNTH_104: DEASSIGN statements are not synthesizable.
  always @(posedge event_signal) begin
    deassign my_reg;
  end

endmodule
