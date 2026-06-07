module curve_w467_20260110_211456_attempt1 (
  output [3:0] out1,
  output [3:0] out2
);

  assign out1 = 4'b10?1; // Triggers W467
  assign out2 = 4'b0?10; // Triggers W467

endmodule
