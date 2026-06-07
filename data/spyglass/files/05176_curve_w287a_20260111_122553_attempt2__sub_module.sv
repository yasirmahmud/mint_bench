module sub_module (
  input wire in_port_sub,
  output wire out_port_sub
);
  // Use the input to prevent W240 and ensure the module is not empty.
  // Drive the output to prevent unused output warnings.
  assign out_port_sub = in_port_sub;
endmodule
