module LOP_NR_RLML_example2;
  // The 'dynamic_limit' was only used within the non-synthesizable 'initial' block
  // to determine the final value of 'match_count'. It can be removed.
  // reg [3:0] dynamic_limit;

  reg [3:0] match_count;

  // The original 'initial' block calculates that 'match_count' would become 1.
  // dynamic_limit was 7.
  // The loop runs from j=0 to 11.
  // if (j == dynamic_limit) means if (j == 7), which is true exactly once.
  // So, match_count increments once, resulting in match_count = 1.
  // To resolve SYNTH_5143 (initial block ignored for synthesis) and preserve
  // this functional behavior, we assign the determined constant value to 'match_count'
  // using a synthesizable 'always_comb' block.
  always_comb begin
    match_count = 1;
  end

endmodule
