module unsized_concat_example_1 (
  input wire a,
  input wire b,
  output wire [33:0] out
);

  assign out = {a, 1, b};

endmodule
