module LeafModule (
  input wire input_a,
  input wire input_b,
  output wire output_sum
);
  assign output_sum = input_a ^ input_b; // Simple XOR logic
endmodule
