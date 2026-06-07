module div_by_zero_example_2 (
  input [7:0] in_c,
  output [7:0] out_d
);
  localparam ZERO_VAL = 8'd0;
  assign out_d = in_c % ZERO_VAL;
endmodule
