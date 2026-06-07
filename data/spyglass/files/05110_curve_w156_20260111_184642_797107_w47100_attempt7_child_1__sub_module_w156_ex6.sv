module sub_module_w156_ex6 (
  input [5:0] data_port, // Changed port declaration to [5:0] to resolve W156
  output [5:0] out_data
);

  // Use data_port to avoid unused signal warning
  assign out_data = data_port;

endmodule
