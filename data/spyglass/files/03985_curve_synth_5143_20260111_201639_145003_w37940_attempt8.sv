module curve_synth_5143_20260111_201639_145003_w37940_attempt8 (
  input wire a,
  output wire b
);

  // Synthesizable logic: A simple pass-through to ensure the module is functional.
  assign b = a;

  // SYNTH_5143: Initial block is ignored for synthesis.
  // This block explicitly triggers the target rule.
  // It uses a simulation-only construct ($display) without any delays
  // to prevent other lint violations like CheckDelayTimescale-ML.
  initial begin
    $display("INFO: This initial block is for simulation setup only and will be ignored by synthesis.");
  end

endmodule
