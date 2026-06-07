module curve_w467_20260110_211456_attempt2 (
  output [4:0] out1,
  output [5:0] out2
);

  assign out1 = 5'b1?010; // Triggers W467
  assign out2 = 6'b01?101; // Triggers W467

endmodule
