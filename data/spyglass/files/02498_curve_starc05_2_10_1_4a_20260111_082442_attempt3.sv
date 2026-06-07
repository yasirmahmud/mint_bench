module curve_starc05_2_10_1_4a_20260111_082442_attempt3 (
  input wire my_signal,
  output reg output_enable
);

  always @(*) begin
    output_enable = 1'b0; // Default assignment to ensure combinatorial logic

    // STARC05-2.10.1.4a: Signal compared with 'z'
    // This comparison directly triggers the target rule.
    if (my_signal === 1'bz) begin
      output_enable = 1'b1;
    end
  end

endmodule
