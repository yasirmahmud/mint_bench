module curve_synth_78_20260111_070734_attempt4 ();

  // According to the provided context example 2 for SYNTH_78,
  // a 'final' block construct triggers this rule, as it is not synthesizable.
  final begin // SYNTH_78: 'wait' construct is not synthesizable. Ignoring for synthesis
    // This block typically executes at the end of simulation.
    $display("Simulation finished for SYNTH_78 example 4.");
  end

endmodule
