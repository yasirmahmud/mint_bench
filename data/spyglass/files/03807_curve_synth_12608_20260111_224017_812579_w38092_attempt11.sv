module curve_synth_12608_20260111_224017_812579_w38092_attempt11 (
  input wire [1:0] sel,
  input wire       in0,
  input wire       in1,
  input wire       in2,
  input wire       in3,
  output reg       out_reg
);

  // SYNTH_12608 is triggered here because an 'always_latch' block is declared,
  // but the logic inside (a fully specified 'case' statement covering all 'sel' values
  // without a 'default' needed) is purely combinatorial. This design ensures
  // 'out_reg' is always assigned a value, thus not inferring any latch. This mismatch
  // between the explicit 'always_latch' block type and the inferred combinatorial
  // hardware logic causes the violation.
  always_latch begin
    case (sel)
      2'b00: out_reg = in0;
      2'b01: out_reg = in1;
      2'b10: out_reg = in2;
      2'b11: out_reg = in3;
    endcase
  end

endmodule
