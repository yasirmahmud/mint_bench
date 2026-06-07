module div_by_zero_example_1 (
  input [7:0] in_a,
  output [7:0] out_b
);
  assign out_b = in_a / 8'd0;
endmodule
