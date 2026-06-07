module neg_range_example_2(
  input [9:0] data_in
);
  // Fix for W240: Read data_in to resolve the 'declared but not read' violation.
  wire [9:0] dummy_read_data_in;
  assign dummy_read_data_in = data_in;
endmodule
