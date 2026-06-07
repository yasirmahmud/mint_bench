module curve_starc05_2_10_1_4a_20260111_082442_attempt3 (
  input wire my_signal,
  output reg output_enable
);

  always @(*) begin
    // In synthesizable hardware, an input wire will never naturally be in a 'z' state.
    // Therefore, the condition 'my_signal === 1'bz' would never be true in synthesis.
    // To preserve the functional behavior in a synthesizable context, where 'output_enable'
    // would effectively always be 0, we simply assign it to 0.
    // This resolves STARC05-2.10.1.4a, STARC05-2.10.1.4b, SYNTH_5058, and W339a violations.
    output_enable = 1'b0;
  end

endmodule
