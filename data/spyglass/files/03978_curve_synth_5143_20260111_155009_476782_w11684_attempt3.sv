module curve_synth_5143_20260111_155009_476782_w11684_attempt3 ();

  // This initial block is inherently ignored by synthesis tools,
  // directly triggering the SYNTH_5143 violation.
  initial begin
    // A non-synthesizable statement to ensure the initial block is not empty
    // and clearly indicates its purpose, without introducing other linting issues.
    $display("SYNTH_5143: This initial block is ignored for synthesis.");
  end

endmodule
