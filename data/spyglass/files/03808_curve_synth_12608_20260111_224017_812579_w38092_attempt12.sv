module curve_synth_12608_20260111_224017_812579_w38092_attempt12 (
  input wire select,
  input wire data_in1,
  input wire data_in2,
  output reg  result
);

  // SYNTH_12608 is triggered here because an 'always_latch' block is declared,
  // but the logic inside (a combinatorial assignment using a conditional operator)
  // is purely combinatorial. This design ensures 'result' is always assigned a value,
  // thus not inferring any latch. This mismatch between the explicit 'always_latch'
  // block type and the inferred combinatorial hardware logic causes the violation.
  always_latch begin
    result = select ? data_in1 : data_in2;
  end

endmodule
