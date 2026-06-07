module curve_wrn_1470_20260110_232532_attempt1 (
  input [3:0] in_data0,
  input [3:0] in_data1,
  input [3:0] in_data2,
  output [3:0] out_vec0,
  output [3:0] out_vec1,
  output [3:0] out_vec2
);

  reg [3:0] internal_vec_array[0:2];

  always @(*) begin
    // WRN_1470 (1/3): Array pattern keys used in assignment pattern for vector bit positions
    internal_vec_array[0] = '{0: in_data0[0], 1: in_data0[1], default: 1'b0};

    // WRN_1470 (2/3): Array pattern keys used in assignment pattern for vector bit positions
    internal_vec_array[1] = '{2: in_data1[2], 3: in_data1[3], default: 1'b0};

    // WRN_1470 (3/3): Array pattern keys used in assignment pattern for vector bit positions
    internal_vec_array[2] = '{0: in_data2[0], default: 1'b0};
  end

  assign out_vec0 = internal_vec_array[0];
  assign out_vec1 = internal_vec_array[1];
  assign out_vec2 = internal_vec_array[2];

endmodule
