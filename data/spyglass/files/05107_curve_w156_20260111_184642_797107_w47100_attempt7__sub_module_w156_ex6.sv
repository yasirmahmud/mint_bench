module sub_module_w156_ex6 (
  input [0:5] data_port,
  output [5:0] out_data
);

  // Use data_port to avoid unused signal warning
  assign out_data = data_port;

endmodule
