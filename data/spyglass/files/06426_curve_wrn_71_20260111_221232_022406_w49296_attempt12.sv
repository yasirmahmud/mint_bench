module curve_wrn_71_20260111_221232_022406_w49296_attempt12 (
  input [7:0] in_data,
  output [9:0] out_a,
  output [11:0] out_b
);

  // First WRN_71 violation:
  // The localparam 'REP_FACTOR_A' is explicitly defined as a real number (2.5).
  // Even though Verilog truncates it to 2 for replication, SpyGlass reports WRN_71
  // because the multiplier's type is not an integer.
  localparam real REP_FACTOR_A = 2.5;
  assign out_a = {{REP_FACTOR_A{1'b0}}, in_data};

  // Second WRN_71 violation:
  // The expression (3 + 1.2) evaluates to 4.2, which is a real number due to mixed-type operation.
  // Verilog truncates it to 4 for replication, but SpyGlass reports WRN_71
  // because the multiplier's type is not an integer.
  localparam int INT_VAL = 3;
  localparam real REAL_VAL = 1.2;
  assign out_b = {{(INT_VAL + REAL_VAL){1'b0}}, in_data};

endmodule
