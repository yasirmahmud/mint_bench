module my_sub_module (
  input wire data_in_a,
  input wire data_in_b,
  output wire data_out_c
);
  // Simple logic to ensure inputs are used and output is driven.
  assign data_out_c = data_in_a ^ data_in_b;
endmodule
