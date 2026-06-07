module sub_module (
  input  wire sub_data_in,
  output wire sub_data_out
);
  // Simple combinational logic to ensure ports are used within the submodule
  assign sub_data_out = sub_data_in;
endmodule
