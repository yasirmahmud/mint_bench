module curve_wrn_71_20260111_221232_022406_w49296_attempt11 (
  input [7:0] in_data,
  output [9:0] out_a,
  output [9:0] out_b
);

  // First WRN_71 violation:
  // The expression (4.5 - 2) evaluates to 2.5, which is a real number.
  // Verilog will implicitly truncate it to 2 for replication ({2{1'b0}}), 
  // but SpyGlass triggers WRN_71 because the multiplier is not an integer type.
  assign out_a = {{(4.5 - 2){1'b0}}, in_data};

  // Second WRN_71 violation:
  // The expression (9.0 / 4) evaluates to 2.25, which is a real number.
  // Verilog will implicitly truncate it to 2 for replication ({2{1'b0}}), 
  // but SpyGlass triggers WRN_71 because the multiplier is not an integer type.
  assign out_b = {{(9.0 / 4){1'b0}}, in_data};

endmodule
