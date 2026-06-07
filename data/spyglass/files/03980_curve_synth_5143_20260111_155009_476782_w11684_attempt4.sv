module curve_synth_5143_20260111_155009_476782_w11684_attempt4 ();

  // Declare a register that will only be initialized in the initial block.
  // Its value is typically ignored by synthesis, causing the SYNTH_5143 violation.
  reg [7:0] sim_only_reg;

  // This initial block is ignored by synthesis tools,
  // directly triggering the SYNTH_5143 violation.
  initial begin
    // Assign an arbitrary value, which is only relevant for simulation.
    sim_only_reg = 8'hA5;
  end

endmodule
