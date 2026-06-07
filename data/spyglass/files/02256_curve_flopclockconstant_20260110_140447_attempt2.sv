module curve_flopclockconstant_20260110_140447_attempt2 (
  input data_in_1,
  input data_in_2,
  output reg flop_out_1,
  output reg flop_out_2
);

  wire constant_low_clock = 1'b0;

  always @(posedge constant_low_clock) begin
    flop_out_1 <= data_in_1;
  end

  always @(posedge constant_low_clock) begin
    flop_out_2 <= data_in_2;
  end

endmodule
