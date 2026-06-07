module LOP_NR_RLML_example1;
  reg [3:0] threshold_val;
  reg [3:0] count;

  // The original 'initial' block calculates a fixed value for 'threshold_val' (5)
  // and 'count' (which increments 5 times when i < 5, resulting in 5).
  // To resolve the SYNTH_5143 violation (initial block ignored for synthesis)
  // while preserving the functional behavior (threshold_val=5, count=5),
  // we replace the 'initial' block with a synthesizable 'always @*' block
  // that directly assigns these constant values.
  always @* begin
    threshold_val = 5;
    count = 5;
  end

endmodule
