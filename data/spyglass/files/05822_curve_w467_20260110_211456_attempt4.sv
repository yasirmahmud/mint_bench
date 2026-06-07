module curve_w467_20260110_211456_attempt4 (
  output [4:0] out1,
  output [7:0] out2
);

  // W467: Based number 5'b101?1 contains a don't-care (?) - might lead to simulation/synthesis mismatch
  assign out1 = 5'b101?1;

  // W467: Based number 8'b1011_0?10 contains a don't-care (?) - might lead to simulation/synthesis mismatch
  assign out2 = 8'b1011_0?10;

endmodule
