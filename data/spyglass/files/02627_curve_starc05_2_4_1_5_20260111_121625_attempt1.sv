module curve_starc05_2_4_1_5_20260111_121625_attempt1 (
  input wire enable,
  input wire data_in,
  output reg data_out_a,
  output reg data_out_b
);

  reg latch_q1;
  reg latch_q2;

  // Latch 1: latches data_in when enable is high
  always_latch begin
    if (enable) begin
      latch_q1 = data_in;
    end
  end

  // Latch 2: latches latch_q1 when enable is high
  // This creates a two-level latch structure where both levels
  // are enabled by the same phase, triggering STARC05-2.4.1.5.
  always_latch begin
    if (enable) begin
      latch_q2 = latch_q1;
    end
  end

  // Assign outputs to prevent unused signal warnings
  assign data_out_a = latch_q1;
  assign data_out_b = latch_q2;

endmodule
