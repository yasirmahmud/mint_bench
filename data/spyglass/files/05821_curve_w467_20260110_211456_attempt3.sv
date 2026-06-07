module curve_w467_20260110_211456_attempt3 (
  output [3:0] out1,
  output [6:0] out2
);

  // W467: Based number 4'b0?10 contains a don't-care (?) - might lead to simulation/synthesis mismatch
  assign out1 = 4'b0?10;
  // W467: Based number 7'b101?011 contains a don't-care (?) - might lead to simulation/synthesis mismatch
  assign out2 = 7'b101?011;

endmodule
