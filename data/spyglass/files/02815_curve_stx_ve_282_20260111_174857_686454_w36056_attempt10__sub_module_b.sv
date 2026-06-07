// Definition of sub_module_b
module sub_module_b (
  input wire sub_b_input,
  output wire sub_b_output
);
  assign sub_b_output = ~sub_b_input; // Simple logic
endmodule
