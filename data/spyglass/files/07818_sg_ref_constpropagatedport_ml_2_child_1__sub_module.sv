module sub_module (input in_port);
  // Fix: Add internal logic to use in_port and make the module non-empty
  wire internal_dummy_wire;
  assign internal_dummy_wire = in_port;
 endmodule
