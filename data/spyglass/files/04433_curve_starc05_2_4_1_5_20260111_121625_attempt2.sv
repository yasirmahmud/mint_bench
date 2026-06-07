module curve_starc05_2_4_1_5_20260111_121625_attempt2 (
  input wire enable,
  input wire data_in,
  output reg data_out
);

  reg first_latch; // Output of the first level latch
  reg second_latch; // Output of the second level latch

  // Both 'first_latch' and 'second_latch' infer latches
  // because they are not assigned for all possible conditions (when 'enable' is low).
  // The 'second_latch' takes its input from 'first_latch', and both are
  // enabled by the same signal 'enable', creating a two-level latch structure
  // in the same phase enable, triggering STARC05-2.4.1.5.
  always @* begin
    if (enable) begin
      first_latch = data_in;
      second_latch = first_latch;
    end
  end

  // Drive output to prevent unused signal warning
  assign data_out = second_latch;

endmodule
