module my_component (
  input  data_in_a,
  input  data_in_b,
  output result_out
);
  // Simple combinational logic
  assign result_out = data_in_a ^ data_in_b;
endmodule
