module curve_synth_5143_20260111_155009_476782_w11684_attempt5 ();

  // This initial block will be ignored by synthesis tools,
  // directly triggering the SYNTH_5143 violation.
  initial begin
    // Declare a register local to this initial block.
    // This avoids 'set but not read' warnings (like W528) for module-level registers,
    // as this variable's scope is confined to the simulation-only initial block.
    reg [7:0] simulation_data;
    simulation_data = 8'hDE;
    // The value assigned here is only relevant for simulation.
  end

endmodule
