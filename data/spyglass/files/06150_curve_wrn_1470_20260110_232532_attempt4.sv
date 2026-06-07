module curve_wrn_1470_20260110_232532_attempt4 (
  input wire in_bit,
  output wire [3:0] out_a,
  output wire [2:0] out_b,
  output wire [1:0] out_c
);

  // WRN_1470 occurrence 1: Array pattern key '0' and '2' in assignment pattern
  assign out_a = '{0: in_bit, 2: 1'b1, default: 1'b0};

  // WRN_1470 occurrence 2: Array pattern key '1' in assignment pattern
  assign out_b = '{1: in_bit, default: 1'b0};

  // WRN_1470 occurrence 3: Array pattern key '1' and '0' in assignment pattern
  assign out_c = '{1: in_bit, 0: 1'b1};

endmodule
