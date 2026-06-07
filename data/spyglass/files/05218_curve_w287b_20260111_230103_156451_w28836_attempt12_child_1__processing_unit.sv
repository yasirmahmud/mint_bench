module processing_unit (
  input wire [7:0] in_a,
  input wire [7:0] in_b,
  output wire [7:0] out_sum,
  output wire out_flag
);

  assign out_sum = in_a + in_b;
  assign out_flag = (in_a > in_b);

endmodule
