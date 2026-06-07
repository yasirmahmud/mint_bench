module GTComparator_4b_GL
(
  input  wire [3:0] in0,
  input  wire [3:0] in1,
  output wire        gt
);
  assign gt = (in0 > in1);
endmodule
